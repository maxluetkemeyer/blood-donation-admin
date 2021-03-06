import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';

class CreateAppointmentHandler extends BackendHandler {
  CreateAppointmentHandler() : super(action: "createAppointment");

  @override
  Map createSendMap([arg]) {
    //Capacities need to be in list format
    Appointment appointment = arg[0];

    //create map
    Map outputMap = {
      "data": appointment.toJson(),
    };

    return outputMap;
  }

  @override
  void receiveLogic(Map json) {
    // TODO: implement recieve
  }
}
