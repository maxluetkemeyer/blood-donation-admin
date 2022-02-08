import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';

class CapacityService {
  //Singleton
  static final CapacityService _instance = CapacityService._private();
  factory CapacityService() => _instance;
  CapacityService._private() {
    print("Starting Capacity Service");
  }

  Map<String, List<Capacity>> capacities = <String, List<Capacity>>{};

  List<Capacity> getCapacitiesPerDay(DateTime day) {
    // ignore: parameter_assignments
    day = extractDay(day);

    if (capacities.containsKey(day.toString())) {
      return capacities[day.toString()]!;
    }

    return [];
  }

  void addCapacity(Capacity capacity) {
    String day = extractDay(capacity.start).toString();

    if (capacities.containsKey(day)) {
      capacities[day]!.add(capacity);
    } else {
      capacities[day] = [capacity];
    }
  }

  void removeCapacity(Capacity capacity) {
    String day = extractDay(capacity.start).toString();

    if (!capacities.containsKey(day)) return;

    capacities[day]!.remove(capacity);
  }

  void clearDay(DateTime day) {
    capacities.remove(day.toString());
  }
}
