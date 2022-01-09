import 'package:blooddonation_admin/misc/env.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import './message_handler.dart' as handler;
import './message_actions.dart' as actions;

// ignore: non_constant_identifier_names
var BackendService = _BackendService();

class _BackendService {
  //Singleton
  static final _BackendService _instance = _BackendService._private();
  factory _BackendService() => _instance;
  _BackendService._private() {
    print("Starting Backend Service");

    init();
  }

  late final WebSocketChannel channel;

  void init() async {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse(WEBSOCKETURI),
      );
    } catch (error) {
      print(error);
    }

    channel.stream.listen(onMessage);
    channel.sink.add("Hello!");
    print("inited");
  }

  void onMessage(message) {
    print(message);

    switch (message.type) {
      case "example":
        handler.exampleMessageHandler(message);
        return;
      default:
        print(message);
    }
  }

  void sendMessage(String message) {
    channel.sink.add(message);
    
  }

  Future sendChangeAllCapacities() => actions.sendChangeAllCapacities();
}
