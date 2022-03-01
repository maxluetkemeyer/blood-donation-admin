import 'package:blooddonation_admin/services/settings/models/donationquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';
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

  final List<DonationQuestion> _donationQuestions = [];
  final List<DonationQuestionTranslation> _donationQuestionTranslation = [];
  final List<DonationController> _donationController = [];

  /*
  Getter
  */

  ///get the current list of all [DonationQuestion]'s.
  List<DonationQuestion> getDonationQuestions() {
    return _donationQuestions;
  }

  ///get the current list of all [DonationQuestion]'s.
  List<DonationQuestionTranslation> getDonationQuestionTranslations() {
    return _donationQuestionTranslation;
  }

  ///get the current list of all [DonationController]'s.
  List<DonationController> getDonationControllers() {
    return _donationController;
  }

  ///Returns one DonationQuestionTranslation with the respective [languageCode] and [questionId] from the [DonationQuestion].
  DonationQuestionTranslation getDonationTranslation({required String languageCode, required int questionId}) {
    DonationQuestionTranslation dqt = DonationQuestionTranslation(id: -1, body: "", language: "", donationQuestion: -1);
    for (int i = 0; i < _donationQuestionTranslation.length; i++) {
      if (_donationQuestionTranslation[i].donationQuestion == questionId && _donationQuestionTranslation[i].language == languageCode) {
        dqt = _donationQuestionTranslation[i];
      }
    }
    return dqt;
  }

  ///Returns all DonationQuestionTranslation with the respective [languageCode] from the [DonationQuestion].
  List<DonationQuestionTranslation> getDonationTranslationList({required String languageCode}) {
    List<DonationQuestionTranslation> dqt = [];
    List<int> questions = [];
    for (int i = 0; i < _donationQuestions.length; i++) {
      questions.add(_donationQuestions[i].id);
    }
    for (int i = 0; i < _donationQuestionTranslation.length; i++) {
      if (questions.contains(_donationQuestionTranslation[i].donationQuestion) && _donationQuestionTranslation[i].language == languageCode) {
        questions.removeAt(questions.indexWhere(((element) {
          if (element == _donationQuestionTranslation[i].donationQuestion) {
            return true;
          }
          return false;
        })));
        dqt.add(_donationQuestionTranslation[i]);
      }
    }
    return dqt;
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

  ///get one [DonationController] by Id.
  DonationControllerTranslation getDonationControllerById({required int id, required String languageCode}) {
    for (int i = 0; i < LanguageService().getLanguages().length; i++) {
      if (_donationController[id].translations[i].lang == languageCode) {
        return _donationController[id].translations[i];
      }
    }

    throw ErrorDescription("Donation Controller with given ID does not exist");
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

  ///Returns the [DonationQuestionTranslation], with the respective [id] and [Language]
  DonationQuestionTranslation getDonationQuestionTranslationByLanguage({required int questionId, required String lang}) {
    var res = _donationQuestionTranslation.where((element) {
      return (element.language == lang && element.donationQuestion == questionId);
    }).isEmpty;

    if (res) {
      throw ErrorDescription("DonationControllerTranslation with given List Id and language does not exist");
    }

    return _donationQuestionTranslation.where((element) {
      return (element.language == lang && element.donationQuestion == questionId);
    }).first;
  }

  ///get one [DonationQuestion] by position.
  DonationQuestion getDonationQuestionByPosition({required int position}) {
    for (int i = 0; i < _donationQuestions.length; i++) {
      if (_donationQuestions[i].position == position) {
        return _donationQuestions[i];
      }
    }
    throw ErrorDescription("Donation Question with given position does not exist");
  }

  ///Returns the length of the current list of [DonationQuestion]'s
  int getDonationQuestionListLength() {
    return _donationQuestions.length;
  }

  int getHighestDonationQuestionId() {
    //Finding highest id of DonationQuestions
    int highest = 0;
    for (int i = 0; i < _donationQuestions.length; i++) {
      if (_donationQuestions[i].id > highest) {
        highest = _donationQuestions[i].id;
      }
    }
    return highest;
  }

  int getHighestDonationQuestionTranslationId() {
    //Finding highest id of DonationQuestionTranslations
    int highest = 0;
    for (int i = 0; i < _donationQuestionTranslation.length; i++) {
      if (_donationQuestionTranslation[i].id > highest) {
        highest = _donationQuestionTranslation[i].id;
      }
    }
    return highest;
  }

  /*
  Setter
  */

  ///Adds a new [DonationQuestion] and a fitting Controller adds them according to their list
  void addDonationQuestion({required DonationQuestionUsing donationTrans}) {
    //Adding new Question to List
    int highest = 0;
    for (int i = 0; i < _donationQuestions.length; i++) {
      if (_donationQuestions[i].id > highest) {
        highest = _donationQuestions[i].id;
      }
    }

    int newQuestionId = highest + 1;
    int pos = _donationQuestions.length;
    _donationQuestions.add(DonationQuestion(
      id: newQuestionId,
      position: pos,
      isYesCorrect: donationTrans.isYesCorrect,
    ));

    highest = 0;

    //Adding Translations and Controller to List
    for (var trans in _donationQuestionTranslation) {
      if (trans.id > highest) {
        highest = trans.id;
      }
    }

    List<DonationControllerTranslation> controllerTrans = [];

    for (var lang in donationTrans.translations) {
      _donationQuestionTranslation.add(DonationQuestionTranslation(
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
    int questionid = _donationQuestions.removeAt(_donationQuestions.indexWhere((element) => element.position == position)).id;
    for (var element in _donationQuestions) {
      if (element.position > position) {
        element.position = element.position - 1;
      }
    }
    _donationQuestionTranslation.removeWhere((element) => element.donationQuestion == questionid);
    _donationController.removeAt(position);
  }

  ///SAVEs the current value of each [DonationController] inside the respective [DonationQuestion]
  void saveDonationControllerState() {
    for (int i = 0; i < _donationQuestionTranslation.length; i++) {
      _donationQuestionTranslation[i].body = getDonationControllerTranslation(
        questionId: _donationQuestionTranslation[i].donationQuestion,
        languageCode: _donationQuestionTranslation[i].language,
      ).bodyController.text;
    }
  }

  ///Function to swap two items inside the [DonationQuestion]- and [DonationController] List.
  void swapDonationQuestions(int oldIndex, int newIndex) {
    //Swapping the variables of position in the DonationQuestions
    DonationQuestion don1 = DonationQuestion(id: -1, position: -1, isYesCorrect: true);
    DonationQuestion don2 = DonationQuestion(id: -1, position: -1, isYesCorrect: true);

    for (int i = 0; i < _donationQuestions.length; i++) {
      if (_donationQuestions[i].position == oldIndex) {
        don1 = _donationQuestions[i];
      } else if (_donationQuestions[i].position == newIndex) {
        don2 = _donationQuestions[i];
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
