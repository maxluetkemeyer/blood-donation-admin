import 'package:blooddonation_admin/models/donationquestions_model.dart';
import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/settings/models/donationquestionusing_model.dart';
import 'package:blooddonation_admin/services/settings/donation_service.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings_view/donation_question/donation_question_tile.dart';
import 'package:blooddonation_admin/settings_view/donation_question/new_donation_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonationQuestionEditView extends StatefulWidget {
  const DonationQuestionEditView({Key? key}) : super(key: key);

  @override
  State<DonationQuestionEditView> createState() => _DonationQuestionEditViewState();
}

class _DonationQuestionEditViewState extends State<DonationQuestionEditView> {
  var lang = LanguageService().getLanguages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsDonationQuestion),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              print("Saving Donation Questions");
              DonationService().saveDonationControllerState();
              //Backend upload
              BackendService().handlers["createDonationQuestions"] = CreateDonationQuestionsHandler()..send();
            },
          )
        ],
      ),
      body: Center(
        child: DonationService().getDonationQuestions().isNotEmpty
            ? ReorderableListView(
                children: getQuestionTiles(DonationService().getDonationQuestions(), lang),
                onReorder: (oldIndex, newIndex) => setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  DonationService().swapDonationQuestions(oldIndex, newIndex);
                }),
              )
            : Center(
                key: const ValueKey("noItemsInList"),
                child: Text(AppLocalizations.of(context)!.settingsDonationEmpty),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => NewDonationQuestion(notifyParents: refreshAdd),
          );
        },
      ),
    );
  }

  ///Returns a [List] of [QuestionTile]'s which are Expandable Tiles that allow the user to change FAQ questions
  List<Widget> getQuestionTiles(
    List<DonationQuestion> donationQuest,
    List<Language> lang,
  ) {
    List<Widget> l = [];
    //Generating DonationQuestionTiles for every Question in donationQuest
    for (int i = 0; i < donationQuest.length; i++) {
      l.add(DonationQuestionTile(
        notifyParents: () => refreshDelete(i),
        iterator: i,
        lang: lang,
        key: ValueKey("${AppLocalizations.of(context)!.question}$i"),
      ));
    }
    return l;
  }

  ///Function is called when a [DonationQuestionTile] is deleted
  void refreshDelete(int i) {
    setState(() {
      DonationService().deleteDonationQuestion(i);
    });
  }

  ///Function is called when a [DonationQuestionTile] is added
  void refreshAdd(DonationQuestionUsing data) {
    setState(() {
      DonationService().addDonationQuestion(donationTrans: data);
    });
  }
}
