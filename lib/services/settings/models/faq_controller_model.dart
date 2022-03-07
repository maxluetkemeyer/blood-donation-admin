import 'package:flutter/widgets.dart';

class FaqController {
  final List<FaqControllerTranslation> translations;
  final int question;

  FaqController({
    required this.question,
    required this.translations,
  });
}

class FaqControllerTranslation {
  TextEditingController headController;
  TextEditingController bodyController;
  String lang;

  FaqControllerTranslation({
    required this.headController,
    required this.bodyController,
    required this.lang,
  });
}
