import 'package:blooddonation_admin/models/faqquestion_model.dart';
import 'package:blooddonation_admin/models/faqquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings_view/faq/new_faq_lang_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: disposing the controllers

///Pop-up window to Add new [Language]s
class NewFaqQuestion extends StatelessWidget {
  final Function notifyParents;

  const NewFaqQuestion({
    Key? key,
    required this.notifyParents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Map of all Controllers for the Question adding process
    FaqController controller = FaqController(translations: [], question: -1);

    ///List of all Languages
    List<Language> lang = LanguageService().getLanguages();
    for (int i = 0; i < lang.length; i++) {
      controller.translations.add(
        FaqControllerTranslation(
          headController: TextEditingController(),
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
              NewFaqLangInput(
                lang: lang,
                controller: controller,
              ),
              const SizedBox(height: 10),
              CupertinoButton.filled(
                onPressed: () {
                  notifyParents(
                    generateFaqQuestion(
                      lang: lang,
                      controller: controller,
                    ),
                  );
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
  List<FaqQuestionUsing> generateFaqQuestion({
    required List<Language> lang,
    required FaqController controller,
  }) {
    List<FaqQuestionUsing> result = [];

    for (int i = 0; i < lang.length; i++) {
      String answer = controller.translations[i].bodyController.text;
      String question = controller.translations[i].headController.text;

      //The FaqQuestion for each language
      result.add(
        FaqQuestionUsing(
          body: answer,
          head: question,
          lang: lang[i].abbr,
        ),
      );
    }

    return result;
  }
}
