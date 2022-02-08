import 'package:blooddonation_admin/services/settings/models/language_model.dart';

class FaqQuestion {
  List<FaqQuestionTranslation> translations;

  FaqQuestion({
    required this.translations,
  });
}

class FaqQuestionTranslation {
  String head;
  String body;
  Language lang;

  FaqQuestionTranslation({
    required this.head,
    required this.body,
    required this.lang,
  });
}
