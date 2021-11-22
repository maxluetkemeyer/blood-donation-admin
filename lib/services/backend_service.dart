import 'package:blooddonation_admin/env.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BackendService {
  static final BackendService instance = BackendService._privateConstructor();

  late final WebSocketChannel channel;

  BackendService._privateConstructor() {
    print("Starting Backend Service");

    init();
  }

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
    print("hi");
    print(message.toString());
    print(message);
  }
}
