import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/settings/models/faqquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/faq_service.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings_view/faq/new_faq_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:blooddonation_admin/settings_view/faq/faq_question_tile.dart';

class FaqEditView extends StatefulWidget {
  const FaqEditView({Key? key}) : super(key: key);

  @override
  State<FaqEditView> createState() => _FaqEditViewState();
}

class _FaqEditViewState extends State<FaqEditView> {
  var lang = LanguageService().getLanguages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsFaq),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              print("Saving Faq");
              FaqService().saveFaqControllerState();
              //Backend upload
              BackendService().handlers["createFaqQuestions"] = CreateFaqQuestionsHandler()..send();
            },
          )
        ],
      ),
      body: Center(
        child: FaqService().getFaqQuestions().isNotEmpty
            ? ReorderableListView(
                children: getQuestionTiles(FaqService().getFaqQuestions(), lang),
                onReorder: (oldIndex, newIndex) => setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  FaqService().swapFaqQuestions(oldIndex, newIndex);
                }),
              )
            : Center(
                key: const ValueKey("noItemsInList"),
                child: Text(AppLocalizations.of(context)!.settingsFaqEmpty),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) => NewFaqQuestion(notifyParents: refreshAdd),
        ),
      ),
    );
  }

  ///Returns a [List] of [QuestionTile]'s which are Expandable Tiles that allow the user to change FAQ questions
  List<Widget> getQuestionTiles(
    List<FaqQuestion> faqQuest,
    List<Language> lang,
  ) {
    List<Widget> l = [];
    for (int i = 0; i < faqQuest.length; i++) {
      l.add(FaqQuestionTile(
        notifyParents: () => refreshDelete(i),
        iterator: i,
        lang: lang,
        key: ValueKey("${AppLocalizations.of(context)!.question}$i"),
      ));
    }
    return l;
  }

  ///Function is called when a [QuestionTile] is deleted
  void refreshDelete(int i) {
    setState(() {
      FaqService().deleteFaqQuestion(i);
    });
  }

  ///Function is called when a [QuestionTile] is added
  void refreshAdd(List<FaqQuestionUsing> data) {
    setState(() {
      FaqService().addFaqQuestionByUsing(faqTrans: data);
    });
  }
}
