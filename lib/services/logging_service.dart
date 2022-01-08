import 'package:blooddonation_admin/services/provider/provider_service.dart';

class LoggingService {
  //Singleton
  static final LoggingService _instance = LoggingService._private();
  factory LoggingService() => _instance;
  LoggingService._private() {
    print("Starting Logging Service");
  }

  List<String> events = [];

  void addEvent(String event) {
    events.add(event);
    ProviderService().container.read(loggingProvider.state).state++;
  }

  Future reload() async {
    return Future.delayed(const Duration(seconds: 1), () {
      ProviderService().container.read(loggingProvider.state).state++;
    });
  }
}
