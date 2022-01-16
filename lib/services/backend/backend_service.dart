import 'dart:convert';

import 'package:blooddonation_admin/misc/env.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_appointment.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_capacities.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_appointments.dart';
import 'package:blooddonation_admin/services/backend/handlers/get_all_capacities.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BackendService {
  //Singleton
  static final BackendService _instance = BackendService._private();
  factory BackendService() => _instance;
  BackendService._private() {
    print("Starting Backend Service");

    init();
  }

  late final WebSocketChannel channel;

  List<BackendHandler> handlers = [
    CreateCapacitiesHandler(),
    CreateAppointmentHandler(),
    GetAllAppointmentsHandler(),
    GetAllCapacitiesHandler(),
  ];

  void init() async {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse(WEBSOCKETURI),
      );
    } catch (error) {
      print(error);
    }

    channel.stream.listen(_onMessage);
    print("inited");
  }

  void _onMessage(message) {
    print(message);
    Map json = const JsonDecoder().convert(message);

    for (BackendHandler handler in handlers) {
      if (handler.action == json["action"]) {
        handler.receive(json);
        return;
      }
    }
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }
}
