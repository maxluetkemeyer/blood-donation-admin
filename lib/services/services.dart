import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_appointments.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_capacities.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

Future<bool> initLoadOfBackendData() async {
  GetAllAppointmentsHandler().send();

  var handler = GetAllCapacitiesHandler(cb: () async {
    print("3");

    await Future.delayed(const Duration(seconds: 2));

    ProviderService().container.read(startProvider.state).state = false;
  });

  BackendService().handlers["getAllCapacities"] = handler;
  print("4");
  handler.send();
  print("5");

  return true;
}
