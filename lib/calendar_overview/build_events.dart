import 'package:blooddonation_admin/misc/appointment_styles.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/event_model/coolcalendar_event_model.dart';
import 'package:flutter/material.dart';

List<CoolCalendarEvent> calendarBuildEventsOfDay({
  required DateTime day,
  required int appointmentLengthInMinutes,
}) {
  print(day);

  List<CoolCalendarEvent> events = [];
  int eventsPerDayLength = (24 * (60 / appointmentLengthInMinutes)).toInt();
  List<int> rows = List.generate(eventsPerDayLength, (index) => 0);

  void _addToEvents({
    required Appointment appointment,
    required BoxDecoration decoration,
    required BoxDecoration decorationHover,
    required Widget child,
  }) {
    int topStep = (Duration(
              milliseconds: appointment.start.millisecondsSinceEpoch - extractDay(appointment.start).millisecondsSinceEpoch,
            ).inMinutes /
            appointmentLengthInMinutes)
        .ceil();
    int topMinutes = Duration(
      hours: appointment.start.hour,
      minutes: appointment.start.minute,
    ).inMinutes;

    int durationSteps = (appointment.duration.inMinutes / appointmentLengthInMinutes).ceil();

    events.add(
      CoolCalendarEvent(
        child: Center(child: child),
        initTopMinutes: topMinutes,
        initHeightMinutes: appointment.duration.inMinutes,
        rowIndex: rows[topStep],
        dragging: false,
        decoration: decoration,
        decorationHover: decorationHover,
        onTap: () {
          ProviderService().container.read(calendarOverviewSelectedAppointmentProvider.state).state = appointment;
        },
      ),
    );

    rows[topStep]++;
    for (int i = topStep + 1; i < topStep + durationSteps; i++) {
      rows[i]++;
    }
  }

  //#############################################################################################################################

  List<Appointment> appointments = CalendarService().getAppointmentsPerDay(day);

  for (Appointment appointment in appointments) {
    BoxDecoration decoration = appointmentDecoration;
    BoxDecoration decorationHover = appointmentDecorationHover;

    String name = (appointment.person?.name ?? "");
    if (name.length > 7) {
      name = name.substring(0, 5) + "..";
    }

    Widget child = Text(
      name,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    if (appointment.request != null && appointment.request!.status != "accepted") {
      switch (appointment.request!.status) {
        case "declined":
          decoration = appointmentDeclinedDecoration;
          decorationHover = appointmentDeclinedDecorationHover;
          break;
        default: //pending
          decoration = appointmentPendingDecoration;
          decorationHover = appointmentPendingDecorationHover;
          child = Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
          break;
      }
    }

    _addToEvents(
      appointment: appointment,
      child: child,
      decoration: decoration,
      decorationHover: decorationHover,
    );
  }

  //#############################################################################################################################

  List<Appointment> mockAppointments = [];
  List<Capacity> dayCapacities = CapacityService().getCapacitiesPerDay(day);

  for (int i = 0; i < eventsPerDayLength; i++) {
    DateTime aktuell = day.add(Duration(minutes: i * appointmentLengthInMinutes));

    bool paint = false;
    Capacity? inCapacity;

    for (Capacity capacity in dayCapacities) {
      if ((aktuell.isAfter(capacity.start) || aktuell.isAtSameMomentAs(capacity.start)) && aktuell.isBefore(capacity.start.add(capacity.duration))) {
        paint = true;
        inCapacity = capacity;
        continue;
      }
    }

    if (!paint) continue;

    for (int j = 0; j < inCapacity!.slots; j++) {
      if (j < rows[i]) continue;

      mockAppointments.add(
        Appointment(
          id: -1,
          start: aktuell,
          duration: Duration(minutes: appointmentLengthInMinutes),
        ),
      );
    }
  }

  for (Appointment appointment in mockAppointments) {
    _addToEvents(
      appointment: appointment,
      child: const SizedBox(),
      decoration: appointmentEmptyDecoration,
      decorationHover: appointmentEmptyDecorationHover,
    );
  }

  return events;
}
