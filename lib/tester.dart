import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/models/request_model.dart';
import 'package:blooddonation_admin/services/settings_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';

class Tester extends StatelessWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoolCalendar(
        discreteStepSize: 24,
        headerTitles: const [Text("Montag")],
        events: [
          CoolCalendarEvent(
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            ballDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Hey"),
            ),
            onChange: (start, end) => print("start $start, end $end"),
          ),
          CoolCalendarEvent(
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            ballDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Hey"),
            ),
          ),
          CoolCalendarEvent(
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 2,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            ballDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Hey"),
            ),
          ),
        ],
      ),
    );
  }
}

void addTestAppointments() {
  CalendarService cs = CalendarService.instance;

  Appointment a1 = Appointment(
    id: "0",
    start: DateTime.now(),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Hans",
    ),
  );
  Appointment a2 = Appointment(
    id: "1",
    start: DateTime.now(),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      name: "Alina",
    ),
  );
  Appointment a3 = Appointment(
    id: "2",
    start: DateTime.now(),
    duration: const Duration(hours: 1),
  );
  Appointment a4 = Appointment(
    id: "3",
    start: DateTime.now(),
    duration: const Duration(hours: 1),
  );
  a4.start = a4.start.add(const Duration(hours: -2));
  Appointment a5 = Appointment(
    id: "4",
    start: extractDay(DateTime.now()).add(
      const Duration(
        days: 10,
        hours: 12,
      ),
    ),
    duration: const Duration(hours: 1),
  );

  cs.addAppointment(a1);
  cs.addAppointment(a2);
  cs.addAppointment(a3);
  cs.addAppointment(a4);
  cs.addAppointment(a5);
}

void addTestRequests() {
  CalendarService cs = CalendarService.instance;

  Appointment a1 = Appointment(
    id: "99",
    start: DateTime.now(),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Lukas",
    ),
    request: Request(
      created: DateTime.now(),
      status: 'pending',
    ),
  );

  Appointment a2 = Appointment(
    id: "98",
    start: DateTime.now(),
    duration: const Duration(hours: 1),
    request: Request(
      created: DateTime.now(),
      status: 'pending',
    ),
  );

  cs.addAppointment(a1);
  cs.addAppointment(a2);
}

void addTestPlannerEvents() {
  SettingsService ss = SettingsService.instance;

  ss.addCapacity(
    Capacity(start: DateTime(2021, 11, 29, 08), duration: const Duration(hours: 4), chairs: 10),
  );

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 02, 09), duration: const Duration(hours: 6), chairs: 10),
  );

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 03, 08), duration: const Duration(hours: 4), chairs: 10),
  );

  ss.addCapacity(
    Capacity(
      start: extractDay(
        DateTime.now(),
      ).add(
        const Duration(hours: 8),
      ),
      duration: const Duration(hours: 14),
      chairs: 8,
    ),
  );
}
