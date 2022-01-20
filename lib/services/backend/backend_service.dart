import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:blooddonation_admin/misc/env.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_appointment.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_capacities.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_appointments.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_capacities.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';

class BackendService {
  //Singleton
  static final BackendService _instance = BackendService._private();
  factory BackendService() => _instance;
  BackendService._private() {
    print("Starting Backend Service");
  }

  late WebSocket ws;

  Map<String, BackendHandler> handlers = {
    "getAllCapacities": GetAllCapacitiesHandler(),
    "getAllAppointments": GetAllAppointmentsHandler(),
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
  }

  void _onMessage(MessageEvent messageEvent) {
    String message = messageEvent.data.toString();
    print(message);

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
