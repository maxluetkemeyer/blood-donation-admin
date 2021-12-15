import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';

class SettingsService {
  static final SettingsService instance = SettingsService._privateConstructor();

  Map capacities = <String, List<Capacity>>{};

  SettingsService._privateConstructor() {
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
