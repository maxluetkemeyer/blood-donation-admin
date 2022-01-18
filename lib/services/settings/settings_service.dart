import 'dart:html';

import 'package:blooddonation_admin/services/provider/provider_service.dart';
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

  ///Example:
  ///[
  /// Language(
  ///   abbr:"de",
  ///   name:"Deutsch",
  /// ),
  /// Language(
  ///   abbr:"en",
  ///   abbr:"Englisch",
  /// ),
  ///]
  List<Language> _languages = [];

  void addLanguage(Language newLanguage) {
    _languages.add(newLanguage);
  }

  List<Language> getLanguages() {
    return _languages;
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
  ///   "de":FaqQuestion(answer:..,question:..)
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

  void saveControllerState() {
    for(int i = 0; i<_faqQuestions.length;i++){
      for(int j = 0;j<_faqQuestions[i].length;i++){
        _faqQuestions[i][j]?.answer=_faqController[i][j]?.answerController.text??"";
        _faqQuestions[i][j]?.question=_faqController[i][j]?.questionController.text??"";
      }
    }
  }

  //TODO: Dispose System für FAQ Editor
  void disposeControllers(){
    for(int i = 0; i<_faqQuestions.length;i++){
      for(int j = 0;j<_faqQuestions[i].length;i++){
        _faqController[i][j]?.answerController.dispose();
        _faqController[i][j]?.questionController.dispose();
      }
    }
  }

  void swapQuestions(int oldIndex, int newIndex) {
    Map<String, FaqQuestion> item = _faqQuestions.removeAt(oldIndex);
    _faqQuestions.insert(newIndex, item);

    Map<String, FaqController> itemController = _faqController.removeAt(oldIndex);
    _faqController.insert(newIndex, itemController);
  }
}

  /*
  This part covers the Donation Question management
  */
  