import 'package:blooddonation_admin/services/settings/models/donation_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///[LangInput] is a widget that generates two input and one [Text] Widget for one question and one language
class DonationInputFields extends StatefulWidget {
  List<Map<String, DonationQuestion>> data;
  String country;
  int iterator;
  String countryName;
  List<Map<String, DonationController>> controllers;

  DonationInputFields(
      {Key? key, required this.data, required this.country, required this.iterator, required this.countryName, required this.controllers})
      : super(key: key);

  @override
  _DonationInputFieldsState createState() => _DonationInputFieldsState();
}

class _DonationInputFieldsState extends State<DonationInputFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: CupertinoFormSection.insetGrouped(
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.countryName,
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
                  placeholder: "",
                  controller: widget.controllers[widget.iterator][widget.country]?.questionController,
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
                  groupValue: widget.data[widget.iterator][widget.country]?.isYesCorrect,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.data[widget.iterator][widget.country]?.isYesCorrect = value ?? false;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.no),
                leading: Radio<bool>(
                  value: false,
                  groupValue: widget.data[widget.iterator][widget.country]?.isYesCorrect,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.data[widget.iterator][widget.country]?.isYesCorrect = value ?? true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox())
      ],
    );
  }
}
