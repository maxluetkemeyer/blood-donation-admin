import 'package:blooddonation_admin/models/donationquestiontranslation_model.dart';
import 'package:blooddonation_admin/services/settings/donation_service.dart';
import 'package:blooddonation_admin/services/settings/faq_service.dart';
import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart' as lm;
import 'package:language_picker/languages.dart' as l;
import 'package:flutter/material.dart';

class LanguageService {
  //Singleton
  static final LanguageService _instance = LanguageService._private();
  factory LanguageService() => _instance;
  LanguageService._private() {
    print("Starting Language Service");
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
  final List<lm.Language> _languages = [];

  void init(List<FaqQuestionTranslation> faqQT) {
    List<l.Language> langcur = [l.Languages.german];

    for (FaqQuestionTranslation translation in faqQT) {
      l.Language lan = l.Language.fromIsoCode(translation.language);

      bool found = false;
      for (l.Language oldLan in langcur) {
        if (oldLan.isoCode == lan.isoCode) {
          found = true;
          break;
        }
      }
      if (!found) {
        langcur.add(lan);
      }
    }

    for(l.Language lang in langcur){
      addLanguage(
        lm.Language(abbr: lang.isoCode,name: lang.name)
      );
    }
  }

  ///Adds one Language to the [_languages] List
  void addLanguage(lm.Language newLanguage) {
    _languages.add(newLanguage);

    //fetch List of all questionIds
    List<int> doquestions = [];
    for (int i = 0; i < DonationService().getDonationQuestionListLength(); i++) {
      doquestions.add(DonationService().getDonationQuestions()[i].id);
    }

    //get the highest translationQuestionId
    int dohighest = -1;
    for (var trans in DonationService().getDonationQuestionTranslations()) {
      if (trans.id > dohighest) {
        dohighest = trans.id;
      }
    }

    //add language to every element of List meaning [_faqController] and [_faqQuestions]
    for (int i = 0; i < DonationService().getDonationQuestionListLength(); i++) {
      DonationService().getDonationControllers()[i].translations.add(DonationControllerTranslation(
            bodyController: TextEditingController(),
            lang: newLanguage.abbr,
          ));
      DonationService().getDonationQuestionTranslations()
          .add(DonationQuestionTranslation(body: "",language: newLanguage.abbr, donationQuestion: DonationService().getDonationQuestions()[i].id, id: dohighest + 1));
      doquestions.removeAt(doquestions.length - 1);
    }

    //fetch List of all questionIds
    List<int> faquestions = [];
    for (int i = 0; i < FaqService().getFaqQuestions().length; i++) {
      faquestions.add(FaqService().getFaqQuestions()[i].id);
    }

    //get the highest translationQuestionId
    int fahighest = -1;
    for (var trans in FaqService().getFaqQuestionsTranslation()) {
      if (trans.id > fahighest) {
        fahighest = trans.id;
      }
    }

    //add language to every element of List meaning [_faqController] and [_faqQuestions]
    for (int i = 0; i < FaqService().getFaqQuestions().length; i++) {
      FaqService().getFaqControllers()[i]
          .translations
          .add(FaqControllerTranslation(bodyController: TextEditingController(), lang: newLanguage.abbr, headController: TextEditingController()));
      FaqService().getFaqQuestionsTranslation()
          .add(FaqQuestionTranslation(body: "", head: "", language: newLanguage.abbr, faqQuestion: FaqService().getFaqQuestions()[i].id, id: fahighest + 1));
      faquestions.removeAt(faquestions.length - 1);
    }
  }

  ///Delete one [Language] by their respective id
  void deleteLanguage(int i) {
    _languages.removeAt(i);
  }

  ///Returns a [List] of all registered [Language]s.
  List<lm.Language> getLanguages() {
    return _languages;
  }

  ///Returns the [Language] with the fitting abbreviation.
  ///
  ///If [_languages] does not contain a Language with the fitting value for [abbr], then an error is thrown.
  lm.Language getLanguagesbyAbbr(String abbr) {
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
}