import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/settings/faq_service.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';

class GetAllFaqQuestionsHandler extends BackendHandler {
  GetAllFaqQuestionsHandler() : super(action: "getAllFaqQuestions");

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

    //Clear old local FaqQuestions and FaqQuestionTranslations
    FaqService().faqQuestions.clear();
    FaqService().faqQuestionTranslation.clear();

    List<FaqQuestion> _faqQuest = [];
    List<FaqQuestionTranslation> _faqQuestTrans = [];

    //Iterate through the json list, create FaqQuestions and add them to the local storage
    for (Map<String, dynamic> jsonFaqQuestion in json["data"]["faqQuestions"]) {
      //create FaqQuestion
      FaqQuestion faqQue = FaqQuestion.fromJson(jsonFaqQuestion);
      //add to local storage
      _faqQuest.add(faqQue);
    }

    //Iterate through the json list, create FaqQuestionTranslationss and add them to the local storage
    for (Map<String, dynamic> jsonFaqQuestionTranslation in json["data"]["faqQuestionTranslations"]) {
      //create FaqQuestionTranslation
      FaqQuestionTranslation faqQueTra = FaqQuestionTranslation.fromJson(jsonFaqQuestionTranslation);
      //add to local storage
      _faqQuestTrans.add(faqQueTra);
    }

    LanguageService().init(_faqQuestTrans);
    FaqService().initFaqQuestion(faqQuest: _faqQuest, faqTrans: _faqQuestTrans);
  }
}
