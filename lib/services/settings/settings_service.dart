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
  final List<Language> _languages = [];

  ///Adds one Language to the [_languages] List
  void addLanguage(Language newLanguage) {
    _languages.add(newLanguage);

    for (int j = 0; j < _donationQuestions.length; j++) {
      _donationController[j].translations.add(DonationControllerTranslation(bodyController: TextEditingController(), lang: newLanguage));
      _donationQuestions[j].translations.add(DonationQuestionTranslation(body: "", lang: newLanguage));
    }

    for (int i = 0; i < _faqQuestions.length; i++) {
      _faqController[i].translations.add(FaqControllerTranslation(bodyController: TextEditingController(), lang: newLanguage, headController: TextEditingController()));
      _faqQuestions[i].translations.add(FaqQuestionTranslation(body: "",head: "", lang: newLanguage));
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

  ///Example:
  ///[
  /// FaqQuestion(
  ///   translations: [
  ///     FaqQuestionTranslation(
  ///       head: ...,
  ///       body: ...,
  ///     	lang: ...,
  ///     ),
  ///     FaqQuestionTranslation(
  ///       head: ...,
  ///       body: ...,
  ///     	lang: ...,
  ///     ),
  ///   ],
  /// ),
  ///]
  final List<FaqQuestion> _faqQuestions = [];
  final List<FaqController> _faqController = [];

  ///Adds a new FaqQuestion and a fitting Controller adds them according to their list.
  void addFaqQuestion(FaqQuestion newQuestion) {
    _faqQuestions.add(newQuestion);
    FaqController newQuestionController = FaqController(translations: []);
    for (int i = 0; i < _languages.length; i++) {
      FaqControllerTranslation entry = FaqControllerTranslation(
        headController: TextEditingController(
          text: newQuestion.translations[i].head,
        ),
        bodyController: TextEditingController(
          text: newQuestion.translations[i].body,
        ),
        lang: _languages[i],
      );
      newQuestionController.translations.add(entry);
    }
    _faqController.add(newQuestionController);
  }

  ///Deletes the Question with [id].
  void deleteFaqQuestion(int id) {
    _faqQuestions.removeAt(id);
    _faqController.removeAt(id);
  }

  ///get the current list of all [FaqQuestion]'s.
  List<FaqQuestion> getFaqQuestions() {
    return _faqQuestions;
  }

  ///get the current list of all [FaqController]'s.
  List<FaqController> getFaqControllers() {
    return _faqController;
  }

  ///get one element of all [FaqQuestion]'s by their [id] in the list
  FaqQuestion getFaqQuestionById(int id) {
    return _faqQuestions[id];
  }

  ///get one element of all [FaqController]'s by their [id] in the list
  FaqController getFaqControllerById(int id) {
    return _faqController[id];
  }

  ///Returns the length of the current list of [FaqQuestion]'s
  int getFaqQuestionListLength() {
    return _faqQuestions.length;
  }

  ///Returns the [FaqQuestionTranslation], with the respective [id] and [Language]
  FaqQuestionTranslation findFaqQuestionTranslation(int id, String lang) {
    return _faqQuestions[id].translations.where((element) {
      return (element.lang.abbr == lang) ? true : false;
    }).first;
  }

  ///Returns the [FaqControllerTranslation], with the respective [id] and [Language]
  FaqControllerTranslation findFaqControllerTranslation(int id, String lang) {
    return _faqController[id].translations.where((element) {
      return (element.lang.abbr == lang) ? true : false;
    }).first;
  }

  ///Saves the current value of each [FaqController] inside the respective [FaqQuestion]
  void saveFaqControllerState() {
    for (int i = 0; i < _faqQuestions.length; i++) {
      for (int j = 0; j < _languages.length; j++) {
        _faqQuestions[i].translations[j].body = _faqController[i].translations[j].bodyController.text;
        _faqQuestions[i].translations[j].head = _faqController[i].translations[j].headController.text;
      }
    }
  }

  ///Dispses every [DonationController] with the index [i]
  void disposeFaqControllers(int i) {
    for (int j = 0; j < _languages.length; j++) {
      _faqController[i].translations[j].bodyController.dispose();
      _faqController[i].translations[j].headController.dispose();
    }
  }

  ///Function to swap two items inside the [FaqQuestion]- and [FaqController] List.
  void swapFaqQuestions(int oldIndex, int newIndex) {
    FaqQuestion item = _faqQuestions.removeAt(oldIndex);
    _faqQuestions.insert(newIndex, item);

    FaqController itemController = _faqController.removeAt(oldIndex);
    _faqController.insert(newIndex, itemController);
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
  final List<DonationController> _donationController = [];

  ///Adds a new [DonationQuestion] and a fitting Controller adds them according to their list
  void addDonationQuestion(DonationQuestion newQuestion) {
    _donationQuestions.add(newQuestion);
    DonationController newQuestionController = DonationController(translations: []);
    for (int i = 0; i < _languages.length; i++) {
      DonationControllerTranslation entry = DonationControllerTranslation(
        lang: _languages[i],
        bodyController: TextEditingController(
          text: newQuestion.translations[i].body,
        ),
      );
      newQuestionController.translations.add(entry);
    }
    _donationController.add(newQuestionController);
  }

  ///Deletes the Question with [id]
  void deleteDonationQuestion(int id) {
    _donationQuestions.removeAt(id);
    _donationController.removeAt(id);
  }

  ///get the current list of all [DonationQuestion]'s.
  List<DonationQuestion> getDonationQuestions() {
    return _donationQuestions;
  }

  ///get the current list of all [DonationController]'s.
  List<DonationController> getDonationControllers() {
    return _donationController;
  }

  ///get one element of all [DonationQuestion]'s by their [id] in the list
  DonationQuestion getDonationQuestionById(int id) {
    return _donationQuestions[id];
  }

  ///get one element of all [DonationController]'s by their [id] in the list
  DonationController getDonationControllerById(int id) {
    return _donationController[id];
  }

  ///Returns the length of the current list of [DonationQuestion]'s
  int getDonationQuestionListLength() {
    return _donationQuestions.length;
  }

  ///Returns the [DonationQuestionTranslation], with the respective [id] and [Language]
  DonationQuestionTranslation findDonationQuestionTranslation(int id, String lang) {
    return _donationQuestions[id].translations.where((element) {
      return (element.lang.abbr == lang) ? true : false;
    }).first;
  }

  ///Returns the [DonationControllerTranslation], with the respective [id] and [Language]
  DonationControllerTranslation findDonationControllerTranslation(int id, String lang) {
    return _donationController[id].translations.where((element) {
      return (element.lang.abbr == lang) ? true : false;
    }).first;
  }

  ///Saves the current value of each [DonationController] inside the respective [DonationQuestion]
  void saveDonationControllerState() {
    for (int i = 0; i < _donationQuestions.length; i++) {
      for (int j = 0; j < _languages.length; j++) {
        _donationQuestions[i].translations[j].body = _donationController[i].translations[j].bodyController.text;
      }
    }
  }

  ///Dispses every [DonationController] with the index [i]
  void disposeDonationControllers(int i) {
    for (int j = 0; j < _languages.length; j++) {
      _donationController[i].translations[j].bodyController.dispose();
    }
  }

  ///Function to swap two items inside the [DonationQuestion]- and [DonationController] List.
  void swapDonationQuestions(int oldIndex, int newIndex) {
    DonationQuestion item = _donationQuestions.removeAt(oldIndex);
    _donationQuestions.insert(newIndex, item);

    DonationController itemController = _donationController.removeAt(oldIndex);
    _donationController.insert(newIndex, itemController);
  }
}
