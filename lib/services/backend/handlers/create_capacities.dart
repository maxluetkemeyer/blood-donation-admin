import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';

class CreateCapacitiesHandler extends BackendHandler {
  CreateCapacitiesHandler() : super(action: "createCapacities");

  ///Send all capacities to the backend which deletes all old entries and inserts all new
  @override
  Map createSendMap([arg]) {
    //Capacities need to be in list format
    List list = [];

    //Add every local Capacity to the list
    CapacityService().capacities.forEach((_, capacityDayList) => list.addAll(capacityDayList));

    //create map
    Map outputMap = {
      "data": list,
    };

    return outputMap;
  }

  ///Clear all old local Capacities and replace them with the newest server capacities
  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 201) {
      print("error");
      print(json);
    }

    //Clear old local Capacities
    CapacityService().capacities = <String, List<Capacity>>{};

    //Iterate through the json list, create capacities and add them to the local storage
    for (Map<String, dynamic> jsonCapacity in json["data"]) {
      //create capacity
      Capacity cap = Capacity.fromJson(jsonCapacity);
      //add to local storage
      CapacityService().addCapacity(cap);
    }

    //TODO: Rebuild widgets?
  }
}
