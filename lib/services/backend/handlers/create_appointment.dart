import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';

class CreateAppointmentHandler extends BackendHandler {
  CreateAppointmentHandler() : super(action: "createAppointment");

  @override
  Map createSendMap([arg]) {
    // ignore: unused_local_variable
    Appointment appointment;

    appointment = arg;

    //create map
    Map outputMap = {
      "data": appointment.toString(),
    };

    return outputMap;
  }

  @override
  void receiveLogic(Map json) {
    // TODO: implement recieve
  }
}
