import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/settings/faq_service.dart';

class CreateFaqQuestionsHandler extends BackendHandler {
  CreateFaqQuestionsHandler() : super(action: "createFaqQuestions");

  ///Send all FaqQuestions and FaqQuestionTranslations to the backend which deletes all old entries and inserts all new
  @override
  Map createSendMap([arg]) {
    List<FaqQuestion> faqQuestions = FaqService().faqQuestions;
    List<FaqQuestionTranslation> faqQuestionTranslations = FaqService().faqQuestionTranslation;

    //create map
    Map outputMap = {
      "data": {
        "questionData": faqQuestions,
        "translationData": faqQuestionTranslations,
      }
    };
    
    return outputMap;
  }

  ///Clear all old local FaqQuestions and FaqQuestionTranslations and replace them with the newest server ones.
  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 201) {
      print("error " + action);
      print(json);
      return;
    }

    //Show ok toast
  }
}
