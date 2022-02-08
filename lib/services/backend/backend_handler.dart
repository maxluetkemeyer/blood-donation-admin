import 'dart:convert';

import 'package:blooddonation_admin/services/backend/backend_service.dart';

abstract class BackendHandler {
  final String action;
  final Function? cb;

  BackendHandler({
    required this.action,
    this.cb,
  });

  Map createSendMap([arg]);
  void receiveLogic(Map json);

  void send([arg]) {
    Map map = createSendMap([arg]);

    map.addAll({
      "request_id": DateTime.now().millisecondsSinceEpoch,
      "action": action,
    });

    String message = const JsonEncoder().convert(map);

    BackendService().sendMessage(message);
  }

  void receive(Map json) {
    receiveLogic(json);
    if (cb != null) {
      cb!();
    }
  }
}
