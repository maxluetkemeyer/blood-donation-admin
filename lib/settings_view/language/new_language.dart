import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewLanguage extends StatefulWidget {
  final List<Language> languages = LanguageService().getLanguages();
  final Function notifyParents;

  NewLanguage({
    Key? key,
    required this.notifyParents,
  }) : super(key: key);

  @override
  State<NewLanguage> createState() => _NewLanguageState();
}

class _NewLanguageState extends State<NewLanguage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController abbrController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoFormSection.insetGrouped(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.settingsLanguageNew,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                footer: const Divider(),
                margin: const EdgeInsets.all(12),
                children: [
                  CupertinoFormRow(
                    prefix: Text(
                      AppLocalizations.of(context)!.settingsLanguageName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: "",
                      controller: nameController,
                    ),
                  ),
                  CupertinoFormRow(
                    prefix: Text(
                      AppLocalizations.of(context)!.settingsLanguageAbbr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: "",
                      controller: abbrController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoButton.filled(
                onPressed: () {
                  setState(() {
                    Language newLanguage = Language(name: nameController.text, abbr: abbrController.text);
                    widget.notifyParents(newLanguage);
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  AppLocalizations.of(context)!.settingsLanguageNewSave,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
