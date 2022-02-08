import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/widgets.dart';

class FaqController {
  List<FaqControllerTranslation> translations;

  FaqController({
    required this.translations,
  });
}

class FaqControllerTranslation {
  TextEditingController headController;
  TextEditingController bodyController;
  Language lang;

  FaqControllerTranslation({
    required this.headController,
    required this.bodyController,
    required this.lang,
  });
}
