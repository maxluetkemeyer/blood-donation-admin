import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/models/request_model.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';

void addTestAppointments() {
  CalendarService cs = CalendarService();

  Appointment a1 = Appointment(
    id: "0",
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Hans",
    ),
  );
  Appointment a2 = Appointment(
    id: "1",
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      name: "Alina",
    ),
  );
  Appointment a3 = Appointment(
    id: "2",
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
  );
  Appointment a4 = Appointment(
    id: "3",
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
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
  CalendarService cs = CalendarService();

  Appointment a1 = Appointment(
    id: "99",
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour + 2)),
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
    start: extractDay(DateTime.now()).add(Duration(hours: 24 + DateTime.now().hour + 2)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Jonas",
    ),
    request: Request(
      created: DateTime.now().add(const Duration(hours: -24)),
      status: 'pending',
    ),
  );

  Appointment a3 = Appointment(
    id: "97",
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour )),
    duration: const Duration(hours: 1),
    request: Request(
      created: DateTime.now(),
      status: 'pending',
    ),
  );

  Appointment a4 = Appointment(
    id: "96",
    start: extractDay(DateTime.now()).add(Duration(hours: 48 + DateTime.now().hour -2)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "female",
      name: "Julia",
    ),
    request: Request(
      created: DateTime.now().add(const Duration(hours: -24)),
      status: 'pending',
    ),
  );

  cs.addAppointment(a1);
  cs.addAppointment(a2);
  cs.addAppointment(a3);
  cs.addAppointment(a4);
}

void addTestPlannerEvents() {
  CapacityService ss = CapacityService();

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 06, 08), duration: const Duration(hours: 4), chairs: 10),
  );

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 09, 09), duration: const Duration(hours: 6), chairs: 10),
  );

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 10, 08), duration: const Duration(hours: 4), chairs: 10),
  );

  ss.addCapacity(
    Capacity(
      start: extractDay(DateTime.now()).add(const Duration(hours: 8)),
      duration: const Duration(hours: 14),
      chairs: 8,
    ),
  );
}
