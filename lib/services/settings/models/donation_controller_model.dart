import 'package:flutter/cupertino.dart';

class DonationController {
  List<DonationControllerTranslation> translations;
  final int question;

  DonationController({
    required this.translations,
    required this.question,
  });
}

class DonationControllerTranslation {
  TextEditingController bodyController;
  String lang;

  DonationControllerTranslation({
    required this.bodyController,
    required this.lang,
  });
}
