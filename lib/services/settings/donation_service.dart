import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/donationquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/models/donationquestions_model.dart';
import 'package:blooddonation_admin/models/donationquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';

class DonationService {
  //Singleton
  static final DonationService _instance = DonationService._private();
  factory DonationService() => _instance;
  DonationService._private() {
    print("Starting Donation Service");
  }

  ///Example:
  ///```[
  /// DonationQuestion(
  ///   id: ...,
  ///   isYesCorrect: ...,
  ///   position: ...,
  /// );
  ///]```
  final List<DonationQuestion> donationQuestions = [];

  ///Example:
  ///```[
  /// DonationQuestionTranslation(
  ///   id: ...,
  ///   body: ...,
  ///   language: ...,
  ///   donationQuestion: ...,
  /// );
  ///]```
  final List<DonationQuestionTranslation> donationQuestionTranslation = [];

  ///Example:
  ///```[
  /// DonationController(
  ///   question: ...,
  ///   translations: [...],
  /// );
  ///]```
  final List<DonationController> _donationController = [];

  /*
  Getter Methods
  */

  ///get the current list of all [DonationQuestion]'s.
  List<DonationQuestion> getDonationQuestions() {
    return donationQuestions;
  }

  ///get the current list of all [DonationQuestion]'s.
  List<DonationQuestionTranslation> getDonationQuestionTranslations() {
    return donationQuestionTranslation;
  }

  ///get the current list of all [DonationController]'s.
  List<DonationController> getDonationControllers() {
    return _donationController;
  }

  ///Returns one DonationControllerTranslation with the respective [languageCode] and [id] from the [DonationController].
  DonationControllerTranslation getDonationControllerTranslation({required String languageCode, required int questionId}) {
    DonationControllerTranslation dqt = DonationControllerTranslation(bodyController: TextEditingController(), lang: "");

    DonationController cont = _donationController.where((element) => element.question == questionId).first;

    for (int i = 0; i < cont.translations.length; i++) {
      if (cont.translations[i].lang == languageCode) {
        return cont.translations[i];
      }
    }

    return dqt;
  }

  ///Returns the [DonationQuestionTranslation], with the respective [id] and [Language]
  DonationControllerTranslation getDonationQuestionControllerTranslationByLanguage({required int id, required String lang}) {
    var res = _donationController[id].translations.where((element) {
      return (element.lang == lang);
    }).isEmpty;

    if (res) {
      throw ErrorDescription("DonationControllerTranslation with given List Id and language does not exist");
    }

    return _donationController[id].translations.where((element) {
      return (element.lang == lang);
    }).first;
  }

  ///get one [DonationQuestion] by position.
  DonationQuestion getDonationQuestionByPosition({required int position}) {
    for (int i = 0; i < donationQuestions.length; i++) {
      if (donationQuestions[i].position == position) {
        return donationQuestions[i];
      }
    }
    throw ErrorDescription("Donation Question with given position does not exist");
  }

  ///Returns the length of the current list of [DonationQuestion]'s
  int getDonationQuestionListLength() {
    return donationQuestions.length;
  }

  int getHighestDonationQuestionId() {
    //Finding highest id of DonationQuestions
    int highest = 0;
    for (int i = 0; i < donationQuestions.length; i++) {
      if (donationQuestions[i].id > highest) {
        highest = donationQuestions[i].id;
      }
    }
    return highest;
  }

  int getHighestDonationQuestionTranslationId() {
    //Finding highest id of DonationQuestionTranslations
    int highest = 0;
    for (int i = 0; i < donationQuestionTranslation.length; i++) {
      if (donationQuestionTranslation[i].id > highest) {
        highest = donationQuestionTranslation[i].id;
      }
    }
    return highest;
  }

  /*
  Setter Methods
  */

  void initDonationQuestion({required List<DonationQuestion> donQuest, required List<DonationQuestionTranslation> donTrans}) {
    donationQuestions.clear();
    donationQuestionTranslation.clear();
    _donationController.clear();

    for (int i = 0; i < donQuest.length; i++) {
      donationQuestions.add(donQuest[i]);
    }

    for (int i = 0; i < donTrans.length; i++) {
      donationQuestionTranslation.add(donTrans[i]);
    }

    for (int i = 0; i < donationQuestions.length; i++) {
      for (int j = 0; j < donationQuestions.length; j++) {
        if (donationQuestions[j].position == i) {
          _donationController.add(DonationController(question: donationQuestions[j].id, translations: []));
          break;
        }
      }
    }

    for (int i = 0; i < donationQuestions.length; i++) {
      for (int j = 0; j < LanguageService().getLanguageListLength(); j++) {
        _donationController[i].translations.add(
              DonationControllerTranslation(
                bodyController: TextEditingController(
                  text: getDonationQuestionTranslations()
                      .where((element) =>
                          element.donationQuestion == donationQuestions[i].id && element.language == LanguageService().getLanguages()[j].abbr)
                      .first
                      .body,
                ),
                lang: LanguageService().getLanguages()[j].abbr,
              ),
            );
      }
    }
  }

  ///Adds a new [DonationQuestion] and a fitting Controller adds them according to their list
  void addDonationQuestionByUsing({required DonationQuestionUsing donationTrans}) {
    //Adding new Question to List

    int newQuestionId = getHighestDonationQuestionId() + 1;
    int pos = donationQuestions.length;
    donationQuestions.add(DonationQuestion(
      id: newQuestionId,
      position: pos,
      isYesCorrect: donationTrans.isYesCorrect,
    ));

    List<DonationControllerTranslation> controllerTrans = [];

    int highest = getHighestDonationQuestionTranslationId();

    for (var lang in donationTrans.translations) {
      donationQuestionTranslation.add(DonationQuestionTranslation(
        id: highest + 1,
        body: lang.body,
        language: lang.lang,
        donationQuestion: newQuestionId,
      ));

      controllerTrans.add(DonationControllerTranslation(
        bodyController: TextEditingController(text: lang.body),
        lang: lang.lang,
      ));

      highest++;
    }

    _donationController.add(DonationController(
      question: newQuestionId,
      translations: controllerTrans,
    ));
  }

  ///DELETEs the Question with [position]
  void deleteDonationQuestion(int position) {
    //Remove question from donationQuestions List
    int questionid = donationQuestions.removeAt(donationQuestions.indexWhere((element) => element.position == position)).id;
    //Subtracting every position by one, if the question comes after the removed question
    for (var element in donationQuestions) {
      if (element.position > position) {
        element.position = element.position - 1;
      }
    }
    //Remove all DonationQuestionTranslation's with the respective questionid
    donationQuestionTranslation.removeWhere((element) => element.donationQuestion == questionid);
    //Remove the donationController
    _donationController.removeAt(position);
  }

  ///SAVEs the current value of each [DonationController] inside the respective [DonationQuestion]
  void saveDonationControllerState() {
    for (int i = 0; i < donationQuestionTranslation.length; i++) {
      donationQuestionTranslation[i].body = getDonationControllerTranslation(
        questionId: donationQuestionTranslation[i].donationQuestion,
        languageCode: donationQuestionTranslation[i].language,
      ).bodyController.text;
    }
  }

  ///Function to swap two items inside the [DonationQuestion]- and [DonationController] List.
  void swapDonationQuestions(int oldIndex, int newIndex) {
    //Swapping the variables of position in the DonationQuestions
    DonationQuestion don1 = DonationQuestion(id: -1, position: -1, isYesCorrect: true);
    DonationQuestion don2 = DonationQuestion(id: -1, position: -1, isYesCorrect: true);

    for (int i = 0; i < donationQuestions.length; i++) {
      if (donationQuestions[i].position == oldIndex) {
        don1 = donationQuestions[i];
      } else if (donationQuestions[i].position == newIndex) {
        don2 = donationQuestions[i];
      }
    }

    int cur = don1.position;
    don1.position = don2.position;
    don2.position = cur;

    //Swapping the variables of position in the DonationControllers
    DonationController cont = _donationController[oldIndex];
    _donationController[oldIndex] = _donationController[newIndex];
    _donationController[newIndex] = cont;
  }
}
