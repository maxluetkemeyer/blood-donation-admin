import 'package:blooddonation_admin/models/donationquestions_model.dart';
import 'package:blooddonation_admin/services/settings/models/donationquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings_view/donation_question/new_donation_input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///Pop-up window to Add new [Language]s
class NewDonationQuestion extends StatefulWidget {
  final Function notifyParents;

  const NewDonationQuestion({
    Key? key,
    required this.notifyParents,
  }) : super(key: key);

  @override
  State<NewDonationQuestion> createState() => _NewDonationQuestionState();
}

class _NewDonationQuestionState extends State<NewDonationQuestion> {
  @override
  Widget build(BuildContext context) {
    ///Map of all Controllers for the Question adding process
    DonationController controller = DonationController(translations: [], question: -1);
    DonationQuestion question = DonationQuestion(id: 1, position: 1, isYesCorrect: true);

    ///List of all Languages
    List<Language> lang = LanguageService().getLanguages();
    for (int i = 0; i < lang.length; i++) {
      controller.translations.add(
        DonationControllerTranslation(
          bodyController: TextEditingController(),
          lang: lang[i].abbr,
        ),
      );
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
                            groupValue: question.isYesCorrect,
                            onChanged: (bool? value) {
                              setState(() {
                                question.isYesCorrect = value ?? false;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.no),
                          leading: Radio<bool>(
                            value: false,
                            groupValue: question.isYesCorrect,
                            onChanged: (bool? value) {
                              setState(() {
                                question.isYesCorrect = value ?? true;
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
                    newQuestion: question,
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
  DonationQuestionUsing generateDonationQuestion({
    required List<Language> lang,
    required DonationController controller,
    required DonationQuestion newQuestion,
  }) {
    DonationQuestionUsing result = DonationQuestionUsing(translations: [], isYesCorrect: newQuestion.isYesCorrect);
    for (int i = 0; i < lang.length; i++) {
      DonationQuestionUsingTrans dtq = DonationQuestionUsingTrans(
        body: "",
        lang: lang[i].abbr,
      );
      String question = controller.translations[i].bodyController.text;

      dtq.body = question;
      //The FaqQuestion for each language
      result.translations.add(dtq);
    }
    return result;
  }
}
