import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';

class GetAllCapacitiesHandler extends BackendHandler {
  GetAllCapacitiesHandler() : super(action: "getAllCapacities");

  @override
  Map createSendMap([arg]) {
    //no data needed
    return {};
  }

  @override
  void receive(Map json) {
    //check response
    if (json["response_status"] != 200) {
      print("error");
      print(json);
    }

    //Clear old local Capacities
    CapacityService().capacities = <String, List<Capacity>>{};

    //Iterate through the json list, create capacities and add them to the local storage
    for (Map<String, dynamic> jsonCapacity in json["data"]) {
      //create capacity
      Capacity capacity = Capacity.fromJson(jsonCapacity);
      //add to local storage
      CapacityService().addCapacity(capacity);
    }

    //TODO: Rebuild widgets
  }
}
