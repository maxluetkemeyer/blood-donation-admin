import 'person_model.dart';
import 'request_model.dart';

class Appointment {
  int id;
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

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"] ?? -1,
        start: DateTime.parse(json["start"]),
        duration: Duration(minutes: json["duration"]),
        request: json["request"] != null ? Request.fromJson(json["request"]) : null,
        person: json["person"] != null ? Person.fromJson(json["person"]) : null,
      );

  @override
  String toString() {
    String requestS = "";
    if (request != null) {
      requestS = request!.status;
    }

    return "Appointment $id " + start.toString() + " " + duration.toString() + " " + requestS;
  }

  Appointment copyWith({
    int? id,
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
          id: -1,
          start: DateTime(0),
          duration: const Duration(),
        );

  EmptyAppointment.free({
    required DateTime start,
    required Duration duration,
  }) : super(
          id: -1,
          start: start,
          duration: duration,
        );
}
