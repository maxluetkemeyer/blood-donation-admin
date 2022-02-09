import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

void reloadFromServer() {
  BackendService().handlers["getAllCapacities"] = GetAllCapacitiesHandler(cb: () async {
    if (ProviderService().container.read(plannerChangedProvider.state).state == true) {
      ProviderService().container.read(plannerChangedProvider.state).state = false;
    } else {
      ProviderService().container.read(plannerUpdateProvider.state).state++;
    }
  })
    ..send();
}
