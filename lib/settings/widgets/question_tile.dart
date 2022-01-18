import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/material.dart';
import './lang_input.dart';

class QuestionTile extends StatefulWidget {
  int iterator;
  List<Map<String, FaqQuestion>> data;
  List<Language> lang;
  List<Map<String, FaqController>> controllers;

  QuestionTile({Key? key, required this.iterator, required this.data, required this.lang, required this.controllers}) : super(key: key);

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  @override
  Widget build(BuildContext context) {
    List<Widget> inputList = [];
    for (int j = 0; j < widget.lang.length; j++) {
      inputList.add(LangInput(
          data: widget.data,
          controllers: widget.controllers,
          country: widget.lang[j].abbr,
          iterator: widget.iterator,
          countryName: widget.lang[j].name));
    }

    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: ExpansionTile(
        key: ValueKey("Frage${widget.iterator + 1}"),
        iconColor: Theme.of(context).primaryColor,
        title: Text(
          "Frage no. ${widget.iterator + 1}",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        collapsedBackgroundColor: Colors.white70,
        backgroundColor: Colors.white70,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: inputList,
            ),
          ),
        ],
      ),
    );
  }
}
