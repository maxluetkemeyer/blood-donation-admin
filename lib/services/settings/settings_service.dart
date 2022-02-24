import 'package:blooddonation_admin/models/donationquestionusing_model.dart';
import 'package:blooddonation_admin/models/faqquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/models/donationquestions_model.dart';
import 'package:blooddonation_admin/models/donationquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/models/faqquestion_model.dart';
import 'package:blooddonation_admin/models/faqquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';

class SettingService {
  //Singleton
  static final SettingService _instance = SettingService._private();
  factory SettingService() => _instance;
  SettingService._private() {
    print("Starting Setting Service");
  }

  /*
  This part covers the Language management
  */

  ///Saves all registered [Language]s.
  ///
  ///Example:
  ///[
  /// Language(
  ///   abbr:"de",
  ///   name:"Deutsch",
  /// ),
  /// Language(
  ///   abbr:"en",
  ///   name:"English",
  /// ),
  ///]
  final List<Language> _languages = [];

  ///Adds one Language to the [_languages] List
  void addLanguage(Language newLanguage) {
    _languages.add(newLanguage);

    //fetch List of all questionIds
    List<int> doquestions = [];
    for (int i = 0; i < _donationQuestions.length; i++) {
      doquestions.add(_donationQuestions[i].id);
    }

    //get the highest translationQuestionId
    int dohighest = -1;
    for (var trans in _donationQuestionTranslation) {
      if (trans.id > dohighest) {
        dohighest = trans.id;
      }
    }

    //add language to every element of List meaning [_faqController] and [_faqQuestions]
    for (int i = 0; i < _donationQuestions.length; i++) {
      _donationController[i].translations.add(DonationControllerTranslation(
            bodyController: TextEditingController(),
            lang: newLanguage.abbr,
          ));
      _donationQuestionTranslation
          .add(DonationQuestionTranslation(body: "",language: newLanguage.abbr, donationQuestion: _donationQuestions[i].id, id: dohighest + 1));
      doquestions.removeAt(doquestions.length - 1);
    }

    //fetch List of all questionIds
    List<int> faquestions = [];
    for (int i = 0; i < _faqQuestions.length; i++) {
      faquestions.add(_faqQuestions[i].id);
    }

    //get the highest translationQuestionId
    int fahighest = -1;
    for (var trans in _faqQuestionTranslation) {
      if (trans.id > fahighest) {
        fahighest = trans.id;
      }
    }

    //add language to every element of List meaning [_faqController] and [_faqQuestions]
    for (int i = 0; i < _faqQuestions.length; i++) {
      _faqController[i]
          .translations
          .add(FaqControllerTranslation(bodyController: TextEditingController(), lang: newLanguage.abbr, headController: TextEditingController()));
      _faqQuestionTranslation
          .add(FaqQuestionTranslation(body: "", head: "", language: newLanguage.abbr, faqQuestion: _faqQuestions[i].id, id: fahighest + 1));
      faquestions.removeAt(faquestions.length - 1);
    }
  }

  ///Delete one [Language] by their respective id
  void deleteLanguage(int i) {
    _languages.removeAt(i);
  }

  ///Returns a [List] of all registered [Language]s.
  List<Language> getLanguages() {
    return _languages;
  }

  ///Returns the [Language] with the fitting abbreviation.
  ///
  ///If [_languages] does not contain a Language with the fitting value for [abbr], then an error is thrown.
  Language getLanguagesbyAbbr(String abbr) {
    for (int i = 0; i < _languages.length; i++) {
      if (_languages[i].abbr == abbr) {
        return _languages[i];
      }
    }
    throw ("List of languages does not include an Object with the abbreviation '$abbr'");
  }

  ///Returns the length of the current list of [Language]'s
  int getLanguageListLength() {
    return _languages.length;
  }

  /*
  This part covers the Faq Question management.
  */

  final List<FaqQuestion> _faqQuestions = [];
  final List<FaqQuestionTranslation> _faqQuestionTranslation = [];
  final List<FaqController> _faqController = [];

  ///Adds a new FaqQuestion and a fitting Controller adds them according to their list.
  void addFaqQuestion({required List<FaqQuestionUsing> faqTrans}) {
    //Adding new Question to List
    int highest = 0;
    for (int i = 0; i < _faqQuestions.length; i++) {
      if (_faqQuestions[i].id > highest) {
        highest = _faqQuestions[i].id;
      }
    }

    int newQuestionId = highest + 1;
    int pos = _faqQuestions.length + 1;
    _faqQuestions.add(FaqQuestion(
      id: newQuestionId,
      position: pos,
    ));
    highest = 0;

    //Adding Translations and Controller to List
    for (var trans in _faqQuestionTranslation) {
      if (trans.id > highest) {
        highest = trans.id;
      }
    }

    List<FaqControllerTranslation> controllerTrans = [];

    for (var lang in faqTrans) {
      _faqQuestionTranslation.add(FaqQuestionTranslation(
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

  ///Returns one FaqQuestionTranslation with the respective [languageCode] and [questionId] from the [FaqQuestion].
  FaqQuestionTranslation getFaqTranslation({required String languageCode, required int questionId}) {
    FaqQuestionTranslation fqt = FaqQuestionTranslation(id: -1, head: "", body: "", language: "", faqQuestion: -1);
    for (int i = 0; i < _faqQuestionTranslation.length; i++) {
      if (_faqQuestionTranslation[i].faqQuestion == questionId && _faqQuestionTranslation[i].language == languageCode) {
        fqt = _faqQuestionTranslation[i];
      }
    }
    return fqt;
  }

  ///Returns all FaqQuestionTranslation with the respective [languageCode] from the [FaqQuestion].
  List<FaqQuestionTranslation> getFaqTranslationList({required String languageCode}) {
    List<FaqQuestionTranslation> fqt = [];
    List<int> questions = [];
    for (int i = 0; i < _faqQuestions.length; i++) {
      questions.add(_faqQuestions[i].id);
    }
    for (int i = 0; i < _faqQuestionTranslation.length; i++) {
      if (questions.contains(_faqQuestionTranslation[i].faqQuestion) && _faqQuestionTranslation[i].language == languageCode) {
        questions.removeAt(questions.indexWhere(((element) {
          if (element == _faqQuestionTranslation[i].faqQuestion) {
            return true;
          }
          return false;
        })));
        fqt.add(_faqQuestionTranslation[i]);
      }
    }
    return fqt;
  }

  ///Returns one FaqControllerTranslation with the respective [languageCode] and [id] from the [FaqController].
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

  ///Returns the [FaqControllerTranslation], with the respective [id] and [Language]
  FaqControllerTranslation getFaqControllerTranslationByLanguage({required int id, required String languageCode}) {
    return _faqController[id].translations.where((element) {
      return (element.lang == languageCode);
    }).first;
  }

  ///get the current list of all [FaqQuestion]'s.
  List<FaqQuestion> getFaqQuestions() {
    return _faqQuestions;
  }

  ///get the current list of all [FaqController]'s.
  List<FaqController> getFaqControllers() {
    return _faqController;
  }

  ///DELETEs the Question with [id].
  void deleteFaqQuestion(int id) {
    _faqQuestions.removeAt(_faqQuestions.indexWhere((element) => element.id == id));
    _faqController.removeAt(id).translations.forEach((element) {
      element.bodyController.dispose();
      element.headController.dispose();
    });
  }

  ///SAVEs the current value of each [FaqController] inside the respective [FaqQuestion]
  void saveFaqControllerState() {
    for (int i = 0; i < _faqQuestionTranslation.length; i++) {
      _faqQuestionTranslation[i].body = getFaqControllerTranslation(
        questionId: _faqQuestionTranslation[i].faqQuestion,
        languageCode: _faqQuestionTranslation[i].language,
      ).bodyController.text;
      _faqQuestionTranslation[i].head = getFaqControllerTranslation(
        questionId: _faqQuestionTranslation[i].faqQuestion,
        languageCode: _faqQuestionTranslation[i].language,
      ).headController.text;
    }
  }

  ///Function to SWAP two items inside the [FaqQuestion]- and [FaqController] List.
  void swapFaqQuestions(int oldIndex, int newIndex) {
    //Swapping the variables of position in the FaqQuestions
    FaqQuestion faq1 = FaqQuestion(id: -1, position: -1);
    FaqQuestion faq2 = FaqQuestion(id: -1, position: -1);

    for (int i = 0; i < _faqQuestions.length; i++) {
      if (_faqQuestions[i].position == oldIndex) {
        faq1 = _faqQuestions[i];
      } else if (_faqQuestions[i].position == newIndex) {
        faq2 = _faqQuestions[i];
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

  int getHighestFaqQuestionId(){
    //Finding highest id of DonationQuestions
    int highest = 0;
    for (int i = 0; i < _faqQuestions.length; i++) {
      if (_faqQuestions[i].id > highest) {
        highest = _faqQuestions[i].id;
      }
    }
    return highest;
  }

  int getHighestFaqQuestionTranslationId(){
    //Finding highest id of DonationQuestionTranslations
    int highest = 0;
    for (int i = 0; i < _faqQuestionTranslation.length; i++) {
      if (_faqQuestionTranslation[i].id > highest) {
        highest = _faqQuestionTranslation[i].id;
      }
    }
    return highest;
  }

  /*
  This part covers the Donation Question management
  */
  ///Example:
  ///[
  /// DonationQuestion(
  ///   translations: [
  ///     DonationQuestionTranslation(
  ///       body: ...,
  ///     	lang: ...,
  ///     ),
  ///     DonationQuestionTranslation(
  ///       body: ...,
  ///     	lang: ...,
  ///     ),
  ///   ],
  ///   isYesCorrect: ...,
  /// ),
  ///]
  final List<DonationQuestion> _donationQuestions = [];
  final List<DonationQuestionTranslation> _donationQuestionTranslation = [];
  final List<DonationController> _donationController = [];

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
    int pos = _donationQuestions.length + 1;
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

  ///Returns the [DonationQuestionTranslation], with the respective [id] and [Language]
  DonationQuestionTranslation getDonationQuestionTranslationByLanguage({required int questionId, required String lang}) {
    return _donationQuestionTranslation.where((element) {
      return (element.language == lang && element.donationQuestion == questionId);
    }).first;
  }

  ///get the current list of all [DonationQuestion]'s.
  List<DonationQuestion> getDonationQuestions() {
    return _donationQuestions;
  }

  ///get one [DonationQuestion] by Id.
  DonationQuestion getDonationQuestionById({required int id}) {
    for(int i = 0; i<_donationQuestions.length;i++){
      if(_donationQuestions[i].id==id){
        return _donationQuestions[id];
      }
    }
    throw ErrorDescription("Donation Question with given ID does not exist");
  }

  ///get one [DonationController] by Id.
  DonationControllerTranslation getDonationControllerById({required int id, required String languageCode}) {
    if(_donationController.length>id){
      for(int i = 0; i<SettingService().getLanguages().length;i++){
        if(_donationController[id].translations[i].lang==languageCode){
          return _donationController[id].translations[i];
        }
      }
    }
    throw ErrorDescription("Donation Question with given ID does not exist");
  }

  ///get the current list of all [DonationController]'s.
  List<DonationController> getDonationControllers() {
    return _donationController;
  }

  ///Returns the length of the current list of [DonationQuestion]'s
  int getDonationQuestionListLength() {
    return _donationQuestions.length;
  }

  ///DELETEs the Question with [id]
  void deleteDonationQuestion(int id) {
    _donationQuestions.removeAt(_donationQuestions.indexWhere((element) => element.id == id));
    _donationController.removeAt(id).translations.forEach((element) {
      element.bodyController.dispose();
    });
  }

  ///SAVEs the current value of each [DonationController] inside the respective [DonationQuestion]
  void saveDonationControllerState() {
    for (int i = 0; i < _donationQuestionTranslation.length; i++) {
      _donationQuestionTranslation[i].body = getFaqControllerTranslation(
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

    for (int i = 0; i < _faqQuestions.length; i++) {
      if (_donationQuestions[i].position == oldIndex) {
        don1 = _donationQuestions[i];
      } else if (_donationQuestions[i].position == newIndex) {
        don1 = _donationQuestions[i];
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

  int getHighestDonationQuestionId(){
    //Finding highest id of DonationQuestions
    int highest = 0;
    for (int i = 0; i < _donationQuestions.length; i++) {
      if (_donationQuestions[i].id > highest) {
        highest = _donationQuestions[i].id;
      }
    }
    return highest;
  }

  int getHighestDonationQuestionTranslationId(){
    //Finding highest id of DonationQuestionTranslations
    int highest = 0;
    for (int i = 0; i < _donationQuestionTranslation.length; i++) {
      if (_donationQuestionTranslation[i].id > highest) {
        highest = _donationQuestionTranslation[i].id;
      }
    }
    return highest;
  }

}
