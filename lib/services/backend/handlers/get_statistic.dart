import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/logging_service.dart';

class GetStatisticHandler extends BackendHandler {
  GetStatisticHandler() : super(action: "getStatistic");

  @override
  Map createSendMap([arg]) {
    //no data need
    return {};
  }

  ///Clear all old local FaqQuestions and FaqQuestionTranslations and replace them with the newest server ones.
  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 200) {
      print("error " + action);
      print(json);
      return;
    }

    List list = json["data"] as List;
    if (list.isEmpty) return;

    Map<String, dynamic> jsonStatistic = json["data"][0];

    LoggingService().statistic = Statistic.fromJson(jsonStatistic);
  }
}
