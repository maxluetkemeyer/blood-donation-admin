import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings/donation_question/donation_input_fields.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonationQuestionTile extends StatefulWidget {
  final Function notifyParents;
  final int iterator;
  final List<Language> lang;

  const DonationQuestionTile(
      {Key? key, required this.notifyParents, required this.iterator, required this.lang})
      : super(key: key);

  @override
  _DonationQuestionTileState createState() => _DonationQuestionTileState();
}

class _DonationQuestionTileState extends State<DonationQuestionTile> {
  @override
  Widget build(BuildContext context) {
    List<Widget> inputList = [];
    for (int j = 0; j < widget.lang.length; j++) {
      inputList.add(
        DonationInputFields(
          country: widget.lang[j].abbr,
          iterator: widget.iterator,
          countryName: widget.lang[j].name,
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ExpansionTile(
        key: ValueKey(
          "${AppLocalizations.of(context)!.question}${widget.iterator + 1}",
        ),
        iconColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${AppLocalizations.of(context)!.question} no. ${widget.iterator + 1}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Row(
              children: [
                buildDeleteButton(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                )
              ],
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        collapsedBackgroundColor: Colors.white70,
        backgroundColor: Colors.white70,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Column(
                    children: [
                      ...inputList,
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
                          groupValue: SettingService().getDonationQuestionById(widget.iterator).isYesCorrect,
                          onChanged: (bool? value) {
                            setState(() {
                              SettingService().getDonationQuestionById(widget.iterator).isYesCorrect = value ?? false;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.no),
                        leading: Radio<bool>(
                          value: false,
                          groupValue: SettingService().getDonationQuestionById(widget.iterator).isYesCorrect,
                          onChanged: (bool? value) {
                            setState(() {
                              SettingService().getDonationQuestionById(widget.iterator).isYesCorrect = value ?? true;
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
          ),
        ],
      ),
    );
  }

  Widget buildDeleteButton() {
    return IconButton(
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(
              AppLocalizations.of(context)!.settingsFaqDeleteTitle,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            content: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.settingsFaqDeleteSubtitle,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                key: const ValueKey('deleteDonationQuestion'),
                isDestructiveAction: true,
                onPressed: () {
                  //Delete Faq Question
                  widget.notifyParents();
                  //pop dialog
                  Navigator.pop(context);
                },
                //child: const Text('Cancel Booking'),
                child: Text(AppLocalizations.of(context)!.delete),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                //pop dialog
                onPressed: () => Navigator.pop(context),
                //child: const Text('Back'),
                child: Text(AppLocalizations.of(context)!.back),
              ),
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.grey,
      ),
    );
  }
}
