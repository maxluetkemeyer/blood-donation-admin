import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: localizations

class NewFaqLangInput extends StatelessWidget {
  List<Language> lang;
  Map<String, FaqController> controller;

  NewFaqLangInput({Key? key, required this.lang, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < lang.length; i++) {
      result.add(
        CupertinoFormSection.insetGrouped(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang[i].name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          footer: const Divider(),
          margin: const EdgeInsets.all(12),
          children: [
            CupertinoFormRow(
              prefix: const Text(
                "Frage",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                placeholder: "Deine Antwort",
                controller: controller[lang[i].abbr]?.questionController,
              ),
            ),
            CupertinoFormRow(
              prefix: const Text(
                "Antwort",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                placeholder: "Deine Antwort",
                controller: controller[lang[i].abbr]?.answerController,
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [...result],
    );
  }
}
