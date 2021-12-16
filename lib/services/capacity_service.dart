import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';

class CapacityService {
  static final CapacityService instance = CapacityService._privateConstructor();

  Map capacities = <String, List<Capacity>>{};

  CapacityService._privateConstructor() {
    print("Starting Settings Service");
  }

  List<Capacity> getCapacitiesPerDay(DateTime day) {
    // ignore: parameter_assignments
    day = extractDay(day);

    if (capacities.containsKey(day.toString())) {
      return capacities[day.toString()];
    }

    return [];
  }

  void addCapacity(Capacity capacity) {
    String day = extractDay(capacity.start).toString();

    if (capacities.containsKey(day)) {
      capacities[day].add(capacity);
    } else {
      capacities[day] = [capacity];
    }
  }
}
