import 'package:blooddonation_admin/models/faqquestion_model.dart';
import 'package:blooddonation_admin/models/faqquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/settings/models/faqquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:flutter/material.dart';

export 'package:blooddonation_admin/models/faqquestion_model.dart';
export 'package:blooddonation_admin/models/faqquestiontranslation_model.dart';

class FaqService {
  //Singleton
  static final FaqService _instance = FaqService._private();
  factory FaqService() => _instance;
  FaqService._private() {
    print("Starting Faq Service");
  }

  /*
  This part covers the Faq Question management.
  */

  final List<FaqQuestion> faqQuestions = [];
  final List<FaqQuestionTranslation> faqQuestionTranslation = [];
  final List<FaqController> _faqController = [];

  /*
  Getter
  */

  ///get the current list of all [FaqQuestion]'s.
  List<FaqQuestion> getFaqQuestions() {
    return faqQuestions;
  }

  ///get the current list of all [FaqQuestionTranslation]'s.
  List<FaqQuestionTranslation> getFaqQuestionsTranslation() {
    return faqQuestionTranslation;
  }

  ///get the current list of all [FaqController]'s.
  List<FaqController> getFaqControllers() {
    return _faqController;
  }

  ///Returns one FaqQuestionTranslation with the respective [languageCode] and [questionId] from the [FaqQuestion].
  FaqQuestionTranslation getFaqTranslation({required String languageCode, required int questionId}) {
    FaqQuestionTranslation fqt = FaqQuestionTranslation(id: -1, head: "", body: "", language: "", faqQuestion: -1);
    for (int i = 0; i < faqQuestionTranslation.length; i++) {
      if (faqQuestionTranslation[i].faqQuestion == questionId && faqQuestionTranslation[i].language == languageCode) {
        fqt = faqQuestionTranslation[i];
      }
    }
    return fqt;
  }

  ///Returns all FaqQuestionTranslation with the respective [languageCode] from the [FaqQuestion].
  List<FaqQuestionTranslation> getFaqTranslationList({required String languageCode}) {
    List<FaqQuestionTranslation> fqt = [];
    List<int> questions = [];
    for (int i = 0; i < faqQuestions.length; i++) {
      questions.add(faqQuestions[i].id);
    }
    for (int i = 0; i < faqQuestionTranslation.length; i++) {
      if (questions.contains(faqQuestionTranslation[i].faqQuestion) && faqQuestionTranslation[i].language == languageCode) {
        questions.removeAt(questions.indexWhere(((element) {
          if (element == faqQuestionTranslation[i].faqQuestion) {
            return true;
          }
          return false;
        })));
        fqt.add(faqQuestionTranslation[i]);
      }
    }
    return fqt;
  }

  ///Returns one FaqControllerTranslation with the respective [languageCode] and [questionId] from the [FaqController].
  FaqControllerTranslation getFaqControllerTranslation({required String languageCode, required int questionId}) {
    FaqControllerTranslation fqt =
        FaqControllerTranslation(bodyController: TextEditingController(), headController: TextEditingController(), lang: "");

    FaqController cont = _faqController.where((element) => element.question == questionId).first;

    for (int i = 0; i < cont.translations.length; i++) {
      if (cont.translations[i].lang == languageCode) {
        return cont.translations[i];
      }
    }

    return fqt;
  }

  ///Returns the [FaqControllerTranslation], with the respective [id] and [languageCode]
  ///
  ///Used in FaqInputFields
  FaqControllerTranslation getFaqControllerTranslationByLanguage({required int id, required String languageCode}) {
    var res = _faqController[id].translations.where((element) {
      return (element.lang == languageCode);
    }).isEmpty;

    if (res) {
      throw ErrorDescription("FaqControllerTranslation with given List Id and language does not exist");
    }

    return _faqController[id].translations.where((element) {
      return (element.lang == languageCode);
    }).first;
  }

  int getHighestFaqQuestionId() {
    //Finding highest id of DonationQuestions
    int highest = 0;
    for (int i = 0; i < faqQuestions.length; i++) {
      if (faqQuestions[i].id > highest) {
        highest = faqQuestions[i].id;
      }
    }
    return highest;
  }

  int getHighestFaqQuestionTranslationId() {
    //Finding highest id of DonationQuestionTranslations
    int highest = 0;
    for (int i = 0; i < faqQuestionTranslation.length; i++) {
      if (faqQuestionTranslation[i].id > highest) {
        highest = faqQuestionTranslation[i].id;
      }
    }
    return highest;
  }

  /*
  Setter and more
  */

  ///Adds a new FaqQuestion and a fitting Controller adds them according to their list.
  void addFaqQuestion({required List<FaqQuestionUsing> faqTrans}) {
    //Adding new Question to List
    int highest = 0;
    for (int i = 0; i < faqQuestions.length; i++) {
      if (faqQuestions[i].id > highest) {
        highest = faqQuestions[i].id;
      }
    }

    int newQuestionId = highest + 1;
    int pos = faqQuestions.length;
    faqQuestions.add(FaqQuestion(
      id: newQuestionId,
      position: pos,
    ));

    highest = 0;

    //Adding Translations and Controller to List
    for (var trans in faqQuestionTranslation) {
      if (trans.id > highest) {
        highest = trans.id;
      }
    }

    List<FaqControllerTranslation> controllerTrans = [];

    for (var lang in faqTrans) {
      faqQuestionTranslation.add(FaqQuestionTranslation(
        id: highest + 1,
        head: lang.head,
        body: lang.body,
        language: lang.lang,
        faqQuestion: newQuestionId,
      ));

      controllerTrans.add(FaqControllerTranslation(
        headController: TextEditingController(text: lang.head),
        bodyController: TextEditingController(text: lang.body),
        lang: lang.lang,
      ));

      highest++;
    }

    _faqController.add(FaqController(question: newQuestionId, translations: controllerTrans));
  }

  ///DELETEs the Question with [position].
  void deleteFaqQuestion(int position) {
    int questionid = faqQuestions.removeAt(faqQuestions.indexWhere((element) => element.position == position)).id;
    for (var element in faqQuestions) {
      if (element.position > position) {
        element.position = position - 1;
      }
    }
    faqQuestionTranslation.removeWhere((element) => element.faqQuestion == questionid);
    _faqController.removeAt(position);
  }

  ///SAVEs the current value of each [FaqController] inside the respective [FaqQuestion]
  void saveFaqControllerState() {
    for (int i = 0; i < faqQuestionTranslation.length; i++) {
      faqQuestionTranslation[i].body = getFaqControllerTranslation(
        questionId: faqQuestionTranslation[i].faqQuestion,
        languageCode: faqQuestionTranslation[i].language,
      ).bodyController.text;
      faqQuestionTranslation[i].head = getFaqControllerTranslation(
        questionId: faqQuestionTranslation[i].faqQuestion,
        languageCode: faqQuestionTranslation[i].language,
      ).headController.text;
    }
  }

  ///Function to SWAP two items inside the [FaqQuestion]- and [FaqController] List.
  void swapFaqQuestions(int oldIndex, int newIndex) {
    //Swapping the variables of position in the FaqQuestions
    FaqQuestion faq1 = FaqQuestion(id: -1, position: -1);
    FaqQuestion faq2 = FaqQuestion(id: -1, position: -1);

    for (int i = 0; i < faqQuestions.length; i++) {
      if (faqQuestions[i].position == oldIndex) {
        faq1 = faqQuestions[i];
      } else if (faqQuestions[i].position == newIndex) {
        faq2 = faqQuestions[i];
      }
    }

    int cur = faq1.position;
    faq1.position = faq2.position;
    faq2.position = cur;

    //Swapping the variables of position in the FaqControllers
    FaqController cont = _faqController[oldIndex];
    _faqController[oldIndex] = _faqController[newIndex];
    _faqController[newIndex] = cont;
  }
}
