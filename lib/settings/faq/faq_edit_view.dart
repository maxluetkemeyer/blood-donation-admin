import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:blooddonation_admin/settings/faq/new_faq_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../services/settings/models/faq_controller_model.dart';
import 'faq_question_tile.dart';

class FaqEditView extends StatefulWidget {
  const FaqEditView({Key? key}) : super(key: key);
  @override
  State<FaqEditView> createState() => _FaqEditViewState();
}

class _FaqEditViewState extends State<FaqEditView> {
  var faqQuestions = SettingService().getFaqQuestions();
  var faqController = SettingService().getFaqControllers();
  var lang = SettingService().getLanguages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsFaq),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              print("Saving Faq");
              SettingService().saveFaqControllerState();
              //TODO: Backend Connection
            },
          )
        ],
      ),
      body: Center(
        child: faqQuestions.isNotEmpty
            ? ReorderableListView(
                children: getQuestionTiles(faqQuestions, lang, faqController),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    SettingService().swapFaqQuestions(oldIndex, newIndex);
                  });
                },
              )
            : const Center(
                key: ValueKey("noItemsInList"),
                child: Text(
                  "Add new Questions to Enable the User sided FAQ",
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return NewFaqQuestion(notifyParents: refreshAdd);
            },
          );
        },
      ),
    );
  }

  ///Returns a [List] of [QuestionTile]'s which are Expandable Tiles that allow the user to change FAQ questions
  List<Widget> getQuestionTiles(List<Map<String, FaqQuestion>> faqQuest, List<Language> lang, List<Map<String, FaqController>> faqContr) {
    List<Widget> l = [];
    for (int i = 0; i < faqQuest.length; i++) {
      l.add(FaqQuestionTile(
        notifyParents: () => refreshDelete(i),
        iterator: i,
        data: faqQuest,
        lang: lang,
        controllers: faqContr,
        key: ValueKey("${AppLocalizations.of(context)!.question}$i"),
      ));
    }
    return l;
  }

  ///Function is called when a [QuestionTile] is deleted
  void refreshDelete(int i) {
    setState(() {
      SettingService().deleteFaqQuestion(i);
    });
  }

  ///Function is called when a [QuestionTile] is added
  void refreshAdd(Map<String, FaqQuestion> data) {
    setState(() {
      SettingService().addFaqQuestion(data);
    });
  }
}
