import 'package:blooddonation_admin/app.dart';
import 'package:blooddonation_admin/connection_view/connection_failed_widget.dart';
import 'package:blooddonation_admin/connection_view/connection_loading_widget.dart';
import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_donationquestions.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_faqquestions.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_statistic.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectionView extends ConsumerWidget {
  const ConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BackendStatus status = ref.watch(backendStatus.state).state;

    if (status == BackendStatus.initializing) {
      BackendService().init(); //Start WebSocket
      return const ConnectionLoading(); //mostly shown very very short
    }
    if (status == BackendStatus.connected) {
      initLoadOfBackendData(); //Load Data
      return const ConnectionLoading();
    }
    if (status == BackendStatus.failed) {
      return const ConnectionFailed();
    }
    if (status == BackendStatus.closed) {
      return const ConnectionFailed();
    }

    //if everything is ready, show normal app || BackendStatus.everythingLoaded
    return const App();
  }
}

void initLoadOfBackendData() {
  // Load all Data from the backend
  GetAllAppointmentsHandler().send();
  GetAllDonationQuestionsHandler().send();
  GetAllFaqQuestionsHandler().send();
  GetStatisticHandler().send();
  // Subscribe to new appointments
  //SubscribeAppointmentsHandler().send();

  //Last Handler with callback to update UI
  var handler = GetAllCapacitiesHandler(cb: () async {
    //for UX to singalize that Data is loaded from a Server
    await Future.delayed(const Duration(seconds: 2));

    ProviderService().container.read(backendStatus.state).state = BackendStatus.everythingLoaded;
  });
  //Replace old instance with new instance including the callback
  BackendService().handlers["getAllCapacities"] = handler;
  handler.send();
}
