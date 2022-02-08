import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NewFaqLangInput extends StatelessWidget {
  final List<Language> lang;
  final FaqController controller;

  const NewFaqLangInput({Key? key, required this.lang, required this.controller}) : super(key: key);

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
              prefix: Text(
                AppLocalizations.of(context)!.question,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                placeholder: AppLocalizations.of(context)!.yourQuestion,
                controller: controller.translations[i].headController,
              ),
            ),
            CupertinoFormRow(
              prefix: Text(
                AppLocalizations.of(context)!.answer,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                placeholder: AppLocalizations.of(context)!.yourAnswer,
                controller: controller.translations[i].bodyController,
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
