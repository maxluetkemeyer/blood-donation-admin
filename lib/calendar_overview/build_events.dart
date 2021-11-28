import 'dart:math';

import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/settings_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<CoolCalendarEvent> calendarBuildEventsOfDay({
  required DateTime day,
  required WidgetRef ref,
}) {
  List<CoolCalendarEvent> events = [];
  List<int> rows = List.generate(48, (index) => 0);

  void _addToEvents({
    required List<Appointment> appointments,
    required String text,
    required BoxDecoration decoration,
    required BoxDecoration decorationHover,
  }) {
    for (Appointment appointment in appointments) {
      int topStep = appointment.start.hour * 2;
      int durationSteps = (appointment.duration.inMinutes / 30).ceil();

      events.add(
        CoolCalendarEvent(
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          initTopMultiplier: topStep,
          initHeightMultiplier: durationSteps,
          rowIndex: rows[topStep],
          dragging: false,
          decoration: decoration,
          decorationHover: decorationHover,
          onTap: () {
            ref.read(calendarOverviewSelectedAppointmentProvider.state).state = appointment;
          },
        ),
      );

      rows[topStep]++;
      for (int i = topStep + 1; i < topStep + durationSteps; i++) {
        rows[i]++;
      }
    }
  }

  //#############################################################################################################################

  List<Appointment> appointments = CalendarService.instance.getAppointmentsPerDay(day);

  _addToEvents(
    appointments: appointments,
    text: "VBS",
    decoration: BoxDecoration(
      color: const Color.fromRGBO(11, 72, 116, 1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.black26,
      ),
    ),
    decorationHover: BoxDecoration(
      color: const Color.fromRGBO(90, 160, 213, 1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
    ),
  );

  //#############################################################################################################################

  List<Appointment> requestAppointments = CalendarService.instance.getRequestsPerDay(day).map((request) => request.appointment).toList();

  _addToEvents(
    appointments: requestAppointments,
    text: "Req",
    decoration: BoxDecoration(
      color: const Color.fromRGBO(180, 209, 228, 1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.black26,
      ),
    ),
    decorationHover: BoxDecoration(
      color: const Color.fromRGBO(90, 160, 213, 1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
    ),
  );

  //#############################################################################################################################

  List<Appointment> mockAppointments = [];
  List<Capacity> dayCapacities = SettingsService.instance.getCapacitiesPerDay(day);

  for (int i = 0; i < 24; i++) {
    DateTime aktuell = day.add(Duration(hours: i));
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
          id: Random.secure().toString(),
          start: aktuell,
          duration: const Duration(hours: 1),
        ),
      );
    }
  }

  _addToEvents(
    appointments: mockAppointments,
    text: "",
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

  return events;
}
