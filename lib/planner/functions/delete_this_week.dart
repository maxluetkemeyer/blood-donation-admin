import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

void deleteThisWeek(DateTime monday) {
  for (int i = 0; i < 7; i++) {
    DateTime day = monday.add(Duration(days: i));
    CapacityService().clearDay(day);
  }

  //Update Widgets
  if (ProviderService().container.read(plannerChangedProvider.state).state) {
    ProviderService().container.read(plannerUpdateProvider.state).state++;
  } else {
    ProviderService().container.read(plannerChangedProvider.state).state = true;
  }
}
