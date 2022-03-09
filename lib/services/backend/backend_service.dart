import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:blooddonation_admin/misc/env.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_appointment.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_capacities.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_appointments.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_capacities.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_donationquestions.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_faqquestions.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_statistic.dart';
import 'package:blooddonation_admin/services/backend/handlers/subscribe_appoinments.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

export './handlers/create_appointment.dart';
export './handlers/create_capacities.dart';
export './handlers/get_all_appointments.dart';
export './handlers/get_all_capacities.dart';
export './handlers/create_donationquestions.dart';
export './handlers/create_faqquestions.dart';

class BackendService {
  //Singleton
  static final BackendService _instance = BackendService._private();
  factory BackendService() => _instance;
  BackendService._private() {
    print("Starting Backend Service");
  }

  late WebSocket ws;

  Map<String, BackendHandler> handlers = {
    "subscribe_to_appointment_activity": SubscribeAppointmentsHandler(),
    "getAllCapacities": GetAllCapacitiesHandler(),
    "getAllAppointments": GetAllAppointmentsHandler(),
    "getAllDonationQuestions": GetAllDonationQuestionsHandler(),
    "getAllFaqQuestions": GetAllFaqQuestionsHandler(),
    "getStatistic": GetStatisticHandler(),
    "createCapacities": CreateCapacitiesHandler(),
    "createAppointment": CreateAppointmentHandler(),
    
  };

  void init() {
    ws = WebSocket(WEBSOCKETURL);

    ws.onOpen.listen((e) {
      print('Websocket connected');
      ProviderService().container.read(backendStatus.state).state = BackendStatus.connected;
    });

    ws.onClose.listen((e) {
      print('Websocket closed');
      ProviderService().container.read(backendStatus.state).state = BackendStatus.closed;
    });

    ws.onError.listen((e) {
      print('Error connecting to Websocket');
      ProviderService().container.read(backendStatus.state).state = BackendStatus.failed;
    });

    ws.onMessage.listen(_onMessage);

    //Check Timeout
    Future.delayed(const Duration(seconds: 3)).then((_) {
      BackendStatus statusLater = ProviderService().container.read(backendStatus.state).state;
      if (statusLater == BackendStatus.initializing) {
        print("Websocket Timeout!");
        ProviderService().container.read(backendStatus.state).state = BackendStatus.failed;
      }
    });
  }

  void _onMessage(MessageEvent messageEvent) {
    String message = messageEvent.data.toString();
    print("[Websocket] " + message);

    Map json = const JsonDecoder().convert(message);

    handlers[json["action"]]?.receive(json);
  }

  void sendMessage(String message) {
    ws.sendString(message);
  }
}

enum BackendStatus {
  initializing,
  connected,
  closed,
  failed,
  everythingLoaded,
}
