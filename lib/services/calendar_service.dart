import 'dart:async';

import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/backend/handlers/subscribe_appoinments.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

import '../models/appointment_model.dart';

class CalendarService {
  //Singleton
  static final CalendarService _instance = CalendarService._private();
  factory CalendarService() => _instance;
  CalendarService._private() {
    print("Starting Calendar Service");
  }

  final Map calendar = <String, List<Appointment>>{};

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

  void removeAppointment(Appointment appointment) {
    calendar.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        Appointment appointmentAtDay = value[i];
        if (appointmentAtDay.id == appointment.id) {
          print("found");
          value.removeAt(i);
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

  List<Appointment> getAppointmentsInHour(DateTime dateHour) {
    DateTime day = extractDay(dateHour);
    List<Appointment> appointmentsThisDay = getAppointmentsPerDay(day);
    List<Appointment> appointmentsInHourInterval = [];

    for (Appointment appointment in appointmentsThisDay) {
      DateTime start = appointment.start;

      if ((start.isAtSameMomentAs(dateHour) || start.isAfter(dateHour)) && start.isBefore(dateHour.add(const Duration(hours: 1)))) {
        appointmentsInHourInterval.add(appointment);
      }
    }

    return appointmentsInHourInterval;
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

  int lastId = 0;
  int newAmount = 0;
  late Timer fetchNewAppointmentsTimer;

  void startTimer() {
    var handler = SubscribeAppointmentsHandler(cb: () async {
      ProviderService().container.read(newAppointmentsProvider.state).state = newAmount;
    });

    //Replace old instance with new instance including the callback
    BackendService().handlers["newAppointments"] = handler;

    fetchNewAppointmentsTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      handler.send();
    });
  }
}
