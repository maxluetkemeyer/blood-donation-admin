import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:blooddonation_admin/settings/widgets/new_faq_question.dart';
import 'package:flutter/material.dart';
import '../../services/settings/models/faq_controller_model.dart';
import '../widgets/question_tile.dart';

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
        title: const Text("Faq Edit Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              SettingService().saveControllerState();
            },
          )
        ],
      ),
      body: Center(
        child: ReorderableListView(
          children: getQuestionTiles(faqQuestions, lang, faqController),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              SettingService().swapQuestions(oldIndex, newIndex);
            });
          },
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
  List<QuestionTile> getQuestionTiles(List<Map<String, FaqQuestion>> faqQuest, List<Language> lang, List<Map<String, FaqController>> faqContr) {
    List<QuestionTile> l = [];
    for (int i = 0; i < faqQuest.length; i++) {
      l.add(QuestionTile(
        notifyParents: () => refreshDelete(i),
        iterator: i,
        data: faqQuest,
        lang: lang,
        controllers: faqContr,
        key: ValueKey("Frage$i"),
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
  void refreshAdd(Map<String,FaqQuestion> data) {
    setState(() {
      SettingService().addFaqQuestion(data);
    });
  }
}
