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
      for (int i = 0; i < value.length; i++) {
        Appointment appointmentAtDay = value[i];
        if (appointmentAtDay.id == appointment.id) {
          print("found");
          value[i] = appointment;
          return;
        }
      }
    });
  }

  List<Appointment> getAppointmentsPerDay(DateTime day) {
    // ignore: parameter_assignments
    day = extractDay(day);

    if (calendar.containsKey(day.toString())) {
      return calendar[day.toString()];
    }

    return [];
  }

  List<Appointment> getRequests({required bool today}) {
    List<Appointment> appointments = [];

    calendar.forEach((dayString, appointmentsAtDay) {
      if (today && dayString != extractDay(DateTime.now()).toString()) return;
      if (!today && dayString == extractDay(DateTime.now()).toString()) return;

      for (Appointment appointment in appointmentsAtDay) {
        if (appointment.request != null && appointment.request!.status == "pending") {
          appointments.add(appointment);
        }
      }
    });

    appointments.sort((appointment1, appointment2) {
      if (appointment1.request!.created.isBefore(appointment2.request!.created)) {
        return -1;
      }

      return 1;
    });

    return appointments;
  }
}
