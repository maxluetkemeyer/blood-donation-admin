import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';

class DeleteAppointmentHandler extends BackendHandler {
  DeleteAppointmentHandler() : super(action: "deleteAppointment");

  @override
  Map createSendMap([arg]) {
    Appointment appointment;

    appointment = arg;

    //create map
    Map outputMap = {
      "id": appointment.id,
    };

    return outputMap;
  }

  @override
  void receiveLogic(Map json) {
    // TODO: implement recieve
  }
}
