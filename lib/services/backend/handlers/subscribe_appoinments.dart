import 'package:blooddonation_admin/services/backend/backend_handler.dart';

class SubscribeAppointmentsHandler extends BackendHandler {
  SubscribeAppointmentsHandler({
    Function? cb,
  }) : super(
          action: "subscribe_to_appointment_activity",
          cb: cb,
        );

  @override
  Map createSendMap([arg]) {
    //no data needed
    return {};
  }

  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 200) {
      print("error");
      print(json);
      return;
    }

    print("Subscribe: " + json.toString());
    /*
    //Clear old local Appointments
    CalendarService().calendar.clear();

    //Iterate through the json list, create capacities and add them to the local storage
    for (Map<String, dynamic> jsonAppointment in json["data"]) {
      //create appointment
      Appointment appointment = Appointment.fromJson(jsonAppointment);
      //add to local storage
      CalendarService().addAppointment(appointment);
    }

    //TODO: Rebuild widgets*/
  }
}
