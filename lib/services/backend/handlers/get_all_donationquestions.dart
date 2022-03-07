import 'package:blooddonation_admin/models/donationquestions_model.dart';
import 'package:blooddonation_admin/models/donationquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/settings/donation_service.dart';

class GetAllDonationQuestionsHandler extends BackendHandler {
  GetAllDonationQuestionsHandler() : super(action: "getAllDonationQuestions");

  @override
  Map createSendMap([arg]) {
    //no data need
    return {};
  }

  ///Clear all old local DonationQuestions and DonationQuestionTranslations and replace them with the newest server ones.
  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 200) {
      print("error " + action);
      print(json);
    }

    //Clear old local DonationQuestions and DonationQuestionTranslations
    DonationService().donationQuestions.clear();
    DonationService().donationQuestionTranslation.clear();

    //Iterate through the json list, create DonationQuestions and add them to the local storage
    for (Map<String, dynamic> jsonDonationQuestion in json["data"]["donationQuestions"]) {
      //create DonationQuestion
      DonationQuestion donQue = DonationQuestion.fromJson(jsonDonationQuestion);
      //add to local storage
      DonationService().donationQuestions.add(donQue);
    }
    //Iterate through the json list, create DonationQuestionTranslationss and add them to the local storage
    for (Map<String, dynamic> jsonDonationQuestionTranslation in json["data"]["donationQuestionTranslations"]) {
      //create DonationQuestion
      DonationQuestionTranslation donQueTra = DonationQuestionTranslation.fromJson(jsonDonationQuestionTranslation);
      //add to local storage
      DonationService().donationQuestionTranslation.add(donQueTra);
    }
  }
}
