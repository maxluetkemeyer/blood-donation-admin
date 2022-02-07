import 'package:blooddonation_admin/services/settings/models/language_model.dart';

class DonationQuestion {
  List<DonationQuestionTranslation> translations;
  bool isYesCorrect;

  DonationQuestion({
    required this.translations,
    required this.isYesCorrect,
  });
}


class DonationQuestionTranslation {
  String body;
  Language lang;

  DonationQuestionTranslation({
    required this.body,
    required this.lang,
  });
}