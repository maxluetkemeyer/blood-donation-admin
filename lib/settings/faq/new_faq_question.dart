import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:blooddonation_admin/settings/faq/new_faq_lang_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


//TODO: disposing the controllers

///Pop-up window to Add new [Language]s
class NewFaqQuestion extends StatelessWidget {
  final Function notifyParents;

  const NewFaqQuestion({Key? key, required this.notifyParents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Map of all Controllers for the Question adding process
    Map<String, FaqController> controller = {};

    ///List of all Languages
    List<Language> lang = SettingService().getLanguages();
    for (int i = 0; i < lang.length; i++) {
      controller[lang[i].abbr] = FaqController(questionController: TextEditingController(), answerController: TextEditingController());
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewFaqLangInput(
                lang: lang,
                controller: controller,
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoButton.filled(
                onPressed: () {
                  notifyParents(generateFaqQuestion(
                    lang: lang,
                    controller: controller,
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

  ///generates the language oriented [Map] for adding the new [FaqQuestion]
  Map<String, FaqQuestion> generateFaqQuestion({required List<Language> lang, required Map<String, FaqController> controller}) {
    Map<String, FaqQuestion> result = {};
    for (int i = 0; i < lang.length; i++) {
      String answer = controller[lang[i].abbr]?.answerController.text ?? "";
      String question = controller[lang[i].abbr]?.questionController.text ?? "";

      //The FaqQuestion for each language
      result[lang[i].abbr] = FaqQuestion(answer: answer, question: question);
    }
    return result;
  }
}
