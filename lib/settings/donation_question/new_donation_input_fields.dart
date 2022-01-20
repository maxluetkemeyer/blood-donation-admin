import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewDonationInputFields extends StatefulWidget {
  List<Language> lang;
  Map<String, DonationController> controller;
  Map<String, DonationQuestion> newQuestion;

  NewDonationInputFields({Key? key, required this.lang, required this.controller, required this.newQuestion}) : super(key: key);

  @override
  State<NewDonationInputFields> createState() => _NewDonationInputFieldsState();
}

class _NewDonationInputFieldsState extends State<NewDonationInputFields> {
  @override
  Widget build(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < widget.lang.length; i++) {
      result.add(
        Row(
          children: [
            Expanded(
              flex: 15,
              child: CupertinoFormSection.insetGrouped(
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.lang[i].name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                footer: const Divider(),
                margin: const EdgeInsets.all(12),
                children: [
                  CupertinoFormRow(
                    prefix: Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: AppLocalizations.of(context)!.yourQuestion,
                      controller: widget.controller[widget.lang[i].abbr]?.questionController,
                    ),
                  ),
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
                      groupValue: widget.newQuestion[widget.lang[i].abbr]?.isYesCorrect,
                      onChanged: (bool? value) {
                        setState(() {
                          print(widget.newQuestion[widget.lang[i].abbr]?.isYesCorrect);
                          widget.newQuestion[widget.lang[i].abbr]?.isYesCorrect = value??false;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.no),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: widget.newQuestion[widget.lang[i].abbr]?.isYesCorrect,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.newQuestion[widget.lang[i].abbr]?.isYesCorrect = value??true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [...result],
    );
  }
}
