import 'package:blooddonation_admin/services/request_model.dart';

import 'appointment_model.dart';

class CalendarService {
  static final CalendarService instance = CalendarService._privateConstructor();

  List<Request> requests = [];
  Map calendar = <String, List<Appointment>>{};

  CalendarService._privateConstructor() {
    print("Starting Calendar Service");

    print(calendar);
  }

  void addAppointment(Appointment appointment) {
    DateTime day = extractDay(appointment.start);

    if (calendar.containsKey(day.toString())) {
      calendar[day.toString()].add(appointment);
    } else {
      calendar[day.toString()] = [appointment];
    }
  }
}

DateTime extractDay(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

void addTestAppointments() {
  CalendarService cs = CalendarService.instance;

  Appointment a1 = Appointment(
    id: "0",
    start: DateTime.now(),
    duration: Duration(hours: 1),
  );
  Appointment a2 = Appointment(
    id: "1",
    start: DateTime.now(),
    duration: Duration(hours: 1),
  );
  Appointment a3 = Appointment(
    id: "2",
    start: DateTime.now(),
    duration: Duration(hours: 1),
  );
  Appointment a4 = Appointment(
    id: "3",
    start: DateTime.now(),
    duration: Duration(hours: 1),
  );
  a4.start = a4.start.add(Duration(hours: -2));

  cs.addAppointment(a1);
  cs.addAppointment(a2);
  cs.addAppointment(a3);
  cs.addAppointment(a4);
}

void addTestRequests() {
  CalendarService cs = CalendarService.instance;

  Appointment a1 = Appointment(
    id: "99",
    start: DateTime.now(),
    duration: Duration(hours: 1),
  );
  Appointment a2 = Appointment(
    id: "98",
    start: DateTime.now(),
    duration: Duration(hours: 1),
  );

  Request r1 = Request(appointment: a1, issued: DateTime.now());
  Request r2 = Request(appointment: a2, issued: DateTime.now());

  cs.requests.add(r1);
  cs.requests.add(r2);
}
