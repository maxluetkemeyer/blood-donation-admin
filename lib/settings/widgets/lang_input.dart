import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: localizations

///[LangInput] is a widget that generates two input and one [Text] Widget for one question and one language
class LangInput extends StatefulWidget {
  List<Map<String, FaqQuestion>> data;
  String country;
  int iterator;
  String countryName;
  List<Map<String, FaqController>> controllers;

  LangInput({Key? key, required this.data, required this.country, required this.iterator, required this.countryName, required this.controllers})
      : super(key: key);

  @override
  _LangInputState createState() => _LangInputState();
}

class _LangInputState extends State<LangInput> {
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
                prefix: const Text(
                  "Frage",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: CupertinoTextFormFieldRow(
                  placeholder: "",
                  controller: widget.controllers[widget.iterator][widget.country]?.questionController,
                ),
              ),
              CupertinoFormRow(
                prefix: const Text(
                  "Antwort",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: CupertinoTextFormFieldRow(
                  placeholder: "",
                  controller: widget.controllers[widget.iterator][widget.country]?.answerController,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox()
        )
      ],
    );
  }
}
