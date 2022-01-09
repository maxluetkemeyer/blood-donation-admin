import 'dart:convert';

import 'package:blooddonation_admin/services/capacity_service.dart';

///Send all capacities to the backend which deletes all old entries and inserts all new
Future<String> sendChangeAllCapacities() {
  Map capacities = CapacityService().capacities;

  List list = [];
  capacities.forEach((_, v) => list.addAll(v));

  Map outputMap = {
    "action": "changeAllCapacities",
    "data": {
      "capacities": list,
    },
  };

  String output = const JsonEncoder().convert(outputMap);

  print(output);

  return Future.value("");
}
