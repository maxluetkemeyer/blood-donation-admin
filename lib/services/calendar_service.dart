import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/request_model.dart';

import '../models/appointment_model.dart';

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

  List<Appointment> getAppointmentsPerDay(DateTime day) {
    if (calendar.containsKey(day.toString())) {
      return calendar[day.toString()];
    }

    return [];
  }

  List<Request> getRequestsPerDay(DateTime day) {
    var fruits = ['apples', 'oranges', 'bananas'];
    fruits.where((f) => f.startsWith('a')).toList(); //apples

    return requests
        .where((r) => extractDay(r.appointment.start).isAtSameMomentAs(day))
        .toList();
  }
}
