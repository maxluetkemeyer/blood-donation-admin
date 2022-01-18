import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
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
      ),
      body: Center(
        child: ReorderableListView(
          children: getQuestionTiles(faqQuestions,lang,faqController),
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
        child: const Icon(Icons.save),
        onPressed: (){

        },
      ),
    );
  }

  ///Returns a [List] of [QuestionTile]'s which are Expandable Tiles that allow the user to change FAQ questions
  List<QuestionTile> getQuestionTiles(List<Map<String, FaqQuestion>> faqQuest, List<Language> lang, List<Map<String, FaqController>> faqContr) {
    List<QuestionTile> l = [];
    for(int i = 0; i < faqQuest.length;i++){
      l.add(QuestionTile(iterator: i,data: faqQuest,lang: lang,controllers:faqContr,key: ValueKey("Frage$i"),));
    }
    return  l;
  }

  ///Saves all current Controllerstates inside the data service
}
