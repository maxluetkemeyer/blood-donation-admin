import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:blooddonation_admin/settings/donation_question/donation_question_tile.dart';
import 'package:blooddonation_admin/settings/donation_question/new_donation_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonationQuestionEditView extends StatefulWidget {
  const DonationQuestionEditView({Key? key}) : super(key: key);
  @override
  State<DonationQuestionEditView> createState() => _DonationQuestionEditViewState();
}

class _DonationQuestionEditViewState extends State<DonationQuestionEditView> {
  ///List to capture all [DonationQuestion]s sorted by questions and then language
  List<Map<String, DonationQuestion>> donationQuestions = SettingService().getDonationQuestions();

  ///List to capture all [DonationController] sorted by questions and then language
  List<Map<String, DonationController>> donationController = SettingService().getDonationControllers();
  var lang = SettingService().getLanguages();

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
              SettingService().saveDonationControllerState();
              //TODO: Backend Connection
            },
          )
        ],
      ),
      body: Center(
        child: donationQuestions.isNotEmpty
            ? ReorderableListView(
                children: getQuestionTiles(donationQuestions, lang, donationController),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    SettingService().swapDonationQuestions(oldIndex, newIndex);
                  });
                },
              )
            : const Center(
                key: ValueKey("noItemsInList"),
                child: Text(
                  "Add new Questions to Enable User sided donation questions",
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return NewDonationQuestion(notifyParents: refreshAdd);
            },
          );
        },
      ),
    );
  }

  ///Returns a [List] of [QuestionTile]'s which are Expandable Tiles that allow the user to change FAQ questions
  List<Widget> getQuestionTiles(
      List<Map<String, DonationQuestion>> donationQuest, List<Language> lang, List<Map<String, DonationController>> donationContr) {
    List<Widget> l = [];
    //Generating DonationQuestionTiles for every Question in donationQuest
    for (int i = 0; i < donationQuest.length; i++) {
      l.add(DonationQuestionTile(
        notifyParents: () => refreshDelete(i),
        iterator: i,
        data: donationQuest,
        lang: lang,
        controllers: donationContr,
        key: ValueKey("${AppLocalizations.of(context)!.question}$i"),
      ));
    }
    return l;
  }

  ///Function is called when a [DonationQuestionTile] is deleted
  void refreshDelete(int i) {
    setState(() {
      SettingService().deleteDonationQuestion(i);
    });
  }

  ///Function is called when a [DonationQuestionTile] is added
  void refreshAdd(Map<String, DonationQuestion> data) {
    setState(() {
      SettingService().addDonationQuestion(data);
    });
  }
}
