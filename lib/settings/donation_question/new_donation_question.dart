import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:blooddonation_admin/settings/donation_question/new_donation_input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///Pop-up window to Add new [Language]s
class NewDonationQuestion extends StatefulWidget {
  final Function notifyParents;

  const NewDonationQuestion({Key? key, required this.notifyParents}) : super(key: key);

  @override
  State<NewDonationQuestion> createState() => _NewDonationQuestionState();
}

class _NewDonationQuestionState extends State<NewDonationQuestion> {
  @override
  Widget build(BuildContext context) {
    ///Map of all Controllers for the Question adding process
    DonationController controller = DonationController(translations: []);

    DonationQuestion newQuestion = DonationQuestion(translations: [], isYesCorrect: true);

    ///List of all Languages
    List<Language> lang = SettingService().getLanguages();
    //Initializing List of DonationControllers
    for (int i = 0; i < lang.length; i++) {
      controller.translations.add(DonationControllerTranslation(bodyController: TextEditingController(), lang: lang[i]));

      newQuestion.translations.add(DonationQuestionTranslation(body: "", lang: lang[i]));
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: Column(
                      children: [
                        NewDonationInputFields(
                          lang: lang,
                          controller: controller,
                          newQuestion: newQuestion,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.correctAnswer}:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.yes),
                          leading: Radio<bool>(
                            value: true,
                            groupValue: newQuestion.isYesCorrect,
                            onChanged: (bool? value) {
                              setState(() {
                                newQuestion.isYesCorrect = value ?? false;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.no),
                          leading: Radio<bool>(
                            value: false,
                            groupValue: newQuestion.isYesCorrect,
                            onChanged: (bool? value) {
                              setState(() {
                                newQuestion.isYesCorrect = value ?? true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoButton.filled(
                onPressed: () {
                  widget.notifyParents(generateDonationQuestion(
                    lang: lang,
                    controller: controller,
                    newQuestion: newQuestion,
                  ));
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.settingsFaqNewSave,
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

  ///generates the language oriented [Map] for adding the new [DonationQuestion]
  DonationQuestion generateDonationQuestion(
      {required List<Language> lang, required DonationController controller, required DonationQuestion newQuestion}) {
    DonationQuestion result = DonationQuestion(translations: [], isYesCorrect: newQuestion.isYesCorrect);
    for (int i = 0; i < lang.length; i++) {
      String question = controller.translations[i].bodyController.text;

      newQuestion.translations[i].body = question;
      //The FaqQuestion for each language
      result.translations.add(newQuestion.translations[i]);
    }
    return result;
  }
}
