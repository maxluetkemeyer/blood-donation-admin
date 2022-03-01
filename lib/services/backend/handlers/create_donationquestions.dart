import 'package:blooddonation_admin/models/donationquestions_model.dart';
import 'package:blooddonation_admin/models/donationquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/backend/backend_handler.dart';
import 'package:blooddonation_admin/services/settings/donation_service.dart';

class CreateDonationQuestionsHandler extends BackendHandler {
  CreateDonationQuestionsHandler() : super(action: "createDonationQuestions");

  ///Send all DonationQuestions and DonationQuestionTranslations to the backend which deletes all old entries and inserts all new
  @override
  Map createSendMap([arg]) {
    List<DonationQuestion> donationQuestions = DonationService().donationQuestions;
    List<DonationQuestionTranslation> donationQuestionTranslations = DonationService().donationQuestionTranslation;

    //create map
    Map outputMap = {
      "data": {
        "questionData": donationQuestions,
        "translationData": donationQuestionTranslations,
      }
    };

    return outputMap;
  }

  ///Clear all old local DonationQuestions and DonationQuestionTranslations and replace them with the newest server ones.
  @override
  void receiveLogic(Map json) {
    //check response
    if (json["response_status"] != 201) {
      print("error " + action);
      print(json);

      //Show error toast
    }

    //Show ok toast
  }
}
