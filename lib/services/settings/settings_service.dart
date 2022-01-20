import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
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
  List<Language> _languages = [];

  ///Adds one Language to the [_languages] List
  void addLanguage(Language newLanguage) {
    _languages.add(newLanguage);
  }

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

  int getLanguageListLength() {
    return _languages.length;
  }

  /*
  This part covers the Faq Question management
  */

  ///Example:
  ///[
  /// {
  ///   "de":FaqQuestion(
  ///     answer:..,
  ///     question:..,
  ///   )
  ///   "en":FaqQuestion(
  ///     answer:..,
  ///     question:..,
  ///   )
  /// }
  ///]
  List<Map<String, FaqQuestion>> _faqQuestions = [];
  List<Map<String, FaqController>> _faqController = [];

  ///Adds a new FaqQuestion and a fitting Controller adds them according to their list
  void addFaqQuestion(Map<String, FaqQuestion> newQuestion) {
    _faqQuestions.add(newQuestion);
    Map<String, FaqController> newQuestionController = {};
    for (int i = 0; i < _languages.length; i++) {
      FaqController entry = FaqController(
        answerController: TextEditingController(
          text: newQuestion[_languages[i].abbr]?.answer,
        ),
        questionController: TextEditingController(
          text: newQuestion[_languages[i].abbr]?.question,
        ),
      );
      newQuestionController[_languages[i].abbr] = entry;
    }
    _faqController.add(newQuestionController);
  }

  ///Deletes the Question with [id]
  void deleteFaqQuestion(int id) {
    _faqQuestions.removeAt(id);
    _faqController.removeAt(id);
  }

  List<Map<String, FaqQuestion>> getFaqQuestions() {
    return _faqQuestions;
  }

  List<Map<String, FaqController>> getFaqControllers() {
    return _faqController;
  }

  Map<String, FaqQuestion> getFaqQuestionById(int id) {
    return _faqQuestions[id];
  }

  Map<String, FaqController> getFaqControllerById(int id) {
    return _faqController[id];
  }

  int getFaqQuestionListLength() {
    return _faqQuestions.length;
  }

  void saveFaqControllerState() {
    for (int i = 0; i < _faqQuestions.length; i++) {
      for (int j = 0; j < _languages.length; i++) {
        _faqQuestions[i][_languages[j].abbr]?.answer = _faqController[i][_languages[j].abbr]?.answerController.text ?? "";
        _faqQuestions[i][_languages[j].abbr]?.question = _faqController[i][_languages[j].abbr]?.questionController.text ?? "";
      }
    }
  }

  //TODO: Dispose System for FAQ Controller
  void disposeFaqControllers(int i) {
    for (int j = 0; j < _languages.length; j++) {
      _faqController[i][_languages[j].abbr]?.answerController.dispose();
      _faqController[i][_languages[j].abbr]?.questionController.dispose();
    }
  }

  void swapFaqQuestions(int oldIndex, int newIndex) {
    Map<String, FaqQuestion> item = _faqQuestions.removeAt(oldIndex);
    _faqQuestions.insert(newIndex, item);

    Map<String, FaqController> itemController = _faqController.removeAt(oldIndex);
    _faqController.insert(newIndex, itemController);
  }

  /*
  This part covers the Donation Question management
  */
  ///Example:
  ///[
  /// {
  ///   "de":DonationQuestion(
  ///     answer:..,
  ///     question:..,
  ///     isYesCorrect:..,
  ///   )
  ///   "en": DonationQuestion(
  ///     answer:..,
  ///     question:..,
  ///     isYesCorrect:..,
  ///   )
  /// }
  ///]
  List<Map<String, DonationQuestion>> _donationQuestions = [];
  List<Map<String, DonationController>> _donationController = [];

  ///Adds a new [DonationQuestion] and a fitting Controller adds them according to their list
  void addDonationQuestion(Map<String, DonationQuestion> newQuestion) {
    _donationQuestions.add(newQuestion);
    Map<String, DonationController> newQuestionController = {};
    for (int i = 0; i < _languages.length; i++) {
      DonationController entry = DonationController(
        questionController: TextEditingController(
          text: newQuestion[_languages[i].abbr]?.question,
        ),
      );
      newQuestionController[_languages[i].abbr] = entry;
    }
    _donationController.add(newQuestionController);
  }

  ///Deletes the Question with [id]
  void deleteDonationQuestion(int id) {
    _donationQuestions.removeAt(id);
    _donationController.removeAt(id);
  }

  List<Map<String, DonationQuestion>> getDonationQuestions() {
    return _donationQuestions;
  }

  List<Map<String, DonationController>> getDonationControllers() {
    return _donationController;
  }

  Map<String, DonationQuestion> getDonationQuestionById(int id) {
    return _donationQuestions[id];
  }

  Map<String, DonationController> getDonationControllerById(int id) {
    return _donationController[id];
  }

  int getDonationQuestionListLength() {
    return _donationQuestions.length;
  }

  void saveDonationControllerState() {
    for (int i = 0; i < _donationQuestions.length; i++) {
      for (int j = 0; j < _languages.length; j++) {
        _donationQuestions[i][_languages[j].abbr]?.question = _donationController[i][_languages[j].abbr]?.questionController.text ?? "";
      }
    }
  }

  //TODO: Dispose System for Donation Controller
  void disposeDonationControllers(int i) {
    for (int j = 0; j < _languages.length; j++) {
      _donationController[i][_languages[j].abbr]?.questionController.dispose();
    }
  }

  void swapDonationQuestions(int oldIndex, int newIndex) {
    Map<String, DonationQuestion> item = _donationQuestions.removeAt(oldIndex);
    _donationQuestions.insert(newIndex, item);

    Map<String, DonationController> itemController = _donationController.removeAt(oldIndex);
    _donationController.insert(newIndex, itemController);
  }
}