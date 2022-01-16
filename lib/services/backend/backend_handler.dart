import 'dart:convert';

import 'package:blooddonation_admin/services/backend/backend_service.dart';

abstract class BackendHandler {
  final String action;

  BackendHandler({
    required this.action,
  });

  Map createSendMap([arg]);
  void receive(Map json);

  void send([arg]) {
    Map map = createSendMap([arg]);

    map.addAll({
      "request_id": DateTime.now().millisecondsSinceEpoch,
      "action": action,
    });

    String message = const JsonEncoder().convert(map);

    BackendService().sendMessage(message);
  }
}
