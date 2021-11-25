import 'appointment_model.dart';

class Request {
  Appointment appointment;
  DateTime issued;

  Request({
    required this.appointment,
    required this.issued,
  });
}
