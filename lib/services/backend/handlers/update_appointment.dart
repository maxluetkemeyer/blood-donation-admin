import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';

class UpdateAppointmentHandler extends BackendHandler {
  UpdateAppointmentHandler() : super(action: "updateAppointment");

  ///Send Appointment
  @override
  Map createSendMap([arg]) {
    print("updatehandler");
    print(arg);
    //Capacities need to be in list format
    Appointment appointment = arg[0];

    print(appointment);

    //create map
    Map outputMap = {
      "id": appointment.id,
      "data": appointment.toJson(),
    };

    return outputMap;
  }

  ///Clear all old local Capacities and replace them with the newest server capacities
  @override
  void receiveLogic(Map json) {
    //update?
  }
}
