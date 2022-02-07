import 'dart:html';

import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';

class DonationController {
  List<DonationControllerTranslation> translations;

  DonationController({
    required this.translations,
  });
}

class DonationControllerTranslation {
  TextEditingController questionController;
  Language lang;

  DonationControllerTranslation({
    required this.questionController,
    required this.lang,
  });
}