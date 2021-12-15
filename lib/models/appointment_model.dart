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
    String requestS = "";
    if (request != null) {
      requestS = request!.status;
    }

    return "Appointment " + id + " " + start.toString() + " " + duration.toString() + " " + requestS;
  }

  Appointment copyWith({
    String? id,
    DateTime? start,
    Duration? duration,
    Request? request,
    Person? person,
  }) {
    return Appointment(
      id: id ?? this.id,
      start: start ?? this.start,
      duration: duration ?? this.duration,
      request: request ?? this.request,
      person: person ?? this.person,
    );
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
