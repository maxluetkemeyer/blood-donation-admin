import 'person_model.dart';
import 'request_model.dart';

class Appointment {
  String id;
  DateTime start;
  Duration duration;
  Request? request;
  Person? person;

  Appointment({
    required this.id,
    required this.start,
    required this.duration,
    this.request,
    this.person,
  });

  @override
  String toString() {
    return "Appointment " + id + " " + start.toString() + " " + duration.toString();
  }
}

class EmptyAppointment extends Appointment {
  EmptyAppointment()
      : super(
          id: "-1",
          start: DateTime(0),
          duration: const Duration(),
        );
}
