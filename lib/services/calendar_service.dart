import 'package:blooddonation_admin/misc/utils.dart';

import '../models/appointment_model.dart';

class CalendarService {
  static final CalendarService instance = CalendarService._privateConstructor();

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

  void updateAppointment(Appointment appointment) {
    calendar.forEach((key, value) {
      for (Appointment appointmentAtDay in value) {
        if (appointmentAtDay.id == appointment.id) {
          print("found");
          appointmentAtDay = appointment;
          return;
        }
      }
    });
  }

  List<Appointment> getAppointmentsPerDay(DateTime day) {
    if (calendar.containsKey(day.toString())) {
      return calendar[day.toString()];
    }

    return [];
  }

  List<Appointment> getRequests() {
    List<Appointment> appointments = [];

    calendar.forEach((key, value) {
      for (Appointment appointment in value) {
        if (appointment.request != null && appointment.request!.status != "accepted") {
          appointments.add(appointment);
        }
      }
    });

    return appointments;
  }
}
