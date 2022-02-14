import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/planner/functions/delete_this_week.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

void copyPreviousWeek(DateTime monday) {
  deleteThisWeek(monday);

  for (int i = 0; i < 7; i++) {
    DateTime dayPreviousWeek = monday.add(Duration(days: i - 7));

    List<Capacity> capacities = CapacityService().getCapacitiesPerDay(dayPreviousWeek);

    for (Capacity capacity in capacities) {
      CapacityService().addCapacity(capacity.copyWith(
        start: capacity.start.add(const Duration(days: 7)),
      ));
    }
  }

  //Update Widgets
  if (ProviderService().container.read(plannerChangedProvider.state).state) {
    ProviderService().container.read(plannerUpdateProvider.state).state++;
  } else {
    ProviderService().container.read(plannerChangedProvider.state).state = true;
  }
}
