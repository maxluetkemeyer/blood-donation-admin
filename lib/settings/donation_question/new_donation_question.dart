import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:blooddonation_admin/settings/donation_question/new_donation_input_fields.dart';
import 'package:flutter/cupertino.dart';
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
    Map<String, DonationController> controller = {};

    Map<String, DonationQuestion> newQuestion = {};

    ///List of all Languages
    List<Language> lang = SettingService().getLanguages();
    //Initializing List of DonationControllers
    for (int i = 0; i < lang.length; i++) {
      controller[lang[i].abbr] = DonationController(questionController: TextEditingController(),);

      newQuestion[lang[i].abbr] = DonationQuestion(question: "",isYesCorrect: true);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewDonationInputFields(
                lang: lang,
                controller: controller,
                newQuestion: newQuestion,
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
  Map<String, DonationQuestion> generateDonationQuestion({required List<Language> lang, required Map<String, DonationController> controller, required Map<String, DonationQuestion> newQuestion}) {
    Map<String, DonationQuestion> result = {};
    for (int i = 0; i < lang.length; i++) {
      String question = controller[lang[i].abbr]?.questionController.text ?? "";

      newQuestion[lang[i].abbr]?.question = question;
      //The FaqQuestion for each language
      result[lang[i].abbr] = newQuestion[lang[i].abbr]??DonationQuestion(question: "",isYesCorrect: true);
    }
    return result;
  }
}
