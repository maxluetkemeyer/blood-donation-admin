import 'appointment_model.dart';

class Request {
  String id;
  DateTime created;
  String status;
  Appointment appointment;

  Request({
    required this.id,
    required this.created,
    required this.status,
    required this.appointment,
  });
}
