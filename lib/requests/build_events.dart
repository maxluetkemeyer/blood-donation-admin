import 'package:blooddonation_admin/calendar_overview/style.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_event_model.dart';
import 'package:flutter/material.dart';

List<CoolCalendarEvent> requestBuildEventsOfDay({
  required Appointment requestedAppointment,
}) {
  if (requestedAppointment is EmptyAppointment) return [];

  List<CoolCalendarEvent> events = [];
  List<int> rows = List.generate(48, (index) => 0);

  void _addToEvents({
    required Appointment appointment,
    required BoxDecoration decoration,
    required BoxDecoration decorationHover,
    required Widget child,
  }) {
    int topStep = appointment.start.hour * 2;
    int durationSteps = (appointment.duration.inMinutes / 30).ceil();

    events.add(
      CoolCalendarEvent(
        child: Center(
          child: child,
        ),
        initTopMultiplier: topStep,
        initHeightMultiplier: durationSteps,
        rowIndex: rows[topStep],
        dragging: false,
        decoration: decoration,
        decorationHover: decorationHover,
      ),
    );

    rows[topStep]++;
    for (int i = topStep + 1; i < topStep + durationSteps; i++) {
      rows[i]++;
    }
  }

  //#############################################################################################################################

  List<Appointment> appointments = CalendarService().getAppointmentsPerDay(requestedAppointment.start);

  for (Appointment appointment in appointments) {
    if (appointment.id == requestedAppointment.id) continue;

    BoxDecoration decoration = BoxDecoration(
      color: const Color.fromRGBO(11, 72, 116, 1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.black26,
      ),
    );

    BoxDecoration decorationHover = BoxDecoration(
      color: const Color.fromRGBO(90, 160, 213, 1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
    );

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
          decoration = BoxDecoration(
            color: requestColor("declined"),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.black26,
            ),
          );
          decorationHover = BoxDecoration(
            color: const Color.fromRGBO(90, 160, 213, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          );
          break;
        default: //pending
          decoration = BoxDecoration(
            color: requestColor("pending"),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.black26,
            ),
          );
          decorationHover = BoxDecoration(
            color: const Color.fromRGBO(90, 160, 213, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          );
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

  String requestedName = (requestedAppointment.person?.name ?? "");
  if (requestedName.length > 7) {
    requestedName = requestedName.substring(0, 5) + "..";
  }

  Widget requestedChild = Text(
    requestedName,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  _addToEvents(
    appointment: requestedAppointment,
    child: requestedChild,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.black26,
      ),
    ),
    decorationHover: BoxDecoration(
      color: Colors.greenAccent,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
    ),
  );

  //#############################################################################################################################

  List<Appointment> mockAppointments = [];
  List<Capacity> dayCapacities = CapacityService().getCapacitiesPerDay(requestedAppointment.start);

  for (int i = 0; i < 24; i++) {
    DateTime aktuell = extractDay(requestedAppointment.start).add(Duration(hours: i));
    bool paint = false;
    Capacity? inCapacity;

    for (Capacity capacity in dayCapacities) {
      if ((aktuell.isAfter(capacity.start) || aktuell.isAtSameMomentAs(capacity.start)) && aktuell.isBefore(capacity.start.add(capacity.duration))) {
        paint = true;
        inCapacity = capacity;
      }
    }

    if (!paint) continue;

    for (int j = 0; j < inCapacity!.chairs; j++) {
      if (j < rows[i * 2]) continue;

      mockAppointments.add(
        Appointment(
          id: "-1",
          start: aktuell,
          duration: const Duration(hours: 1),
        ),
      );
    }
  }

  for (Appointment appointment in mockAppointments) {
    _addToEvents(
      appointment: appointment,
      child: const SizedBox(),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 249, 250, 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.black26,
        ),
      ),
      decorationHover: BoxDecoration(
        color: const Color.fromRGBO(242, 249, 250, 0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  return events;
}
