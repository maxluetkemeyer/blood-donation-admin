import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';

class SubscribeAppointmentsHandler extends BackendHandler {
  SubscribeAppointmentsHandler({
    Function? cb,
  }) : super(action: "newAppointments", cb: cb);

  @override
  Map createSendMap([arg]) {
    //create map
    Map outputMap = {
      "data": {
        "id": CalendarService().lastId,
      },
    };

    return outputMap;
  }

  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 200) {
      print("error");
      print(json);
      return;
    }

    //check response
    if (json["response_status"] != 200) {
      print("error");
      print(json);
      return;
    }

    int amount = 0;

    //Iterate through the json list, create capacities and add them to the local storage
    for (Map<String, dynamic> jsonAppointment in json["data"]) {
      //create appointment
      Appointment appointment = Appointment.fromJson(jsonAppointment);
      //add to local storage
      CalendarService().addAppointment(appointment);

      if (appointment.id > CalendarService().lastId) {
        CalendarService().lastId = appointment.id;
      }

      amount++;
    }

    CalendarService().newAmount += amount;
  }
}
