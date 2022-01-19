import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './lang_input.dart';

//TODO: localizations

class QuestionTile extends StatefulWidget {
  Function notifyParents;
  int iterator;
  List<Map<String, FaqQuestion>> data;
  List<Language> lang;
  List<Map<String, FaqController>> controllers;

  QuestionTile({Key? key, required this.notifyParents, required this.iterator, required this.data, required this.lang, required this.controllers})
      : super(key: key);

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
      padding: const EdgeInsets.only(top: 10),
      child: ExpansionTile(
        key: ValueKey("Frage${widget.iterator + 1}"),
        iconColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Frage no. ${widget.iterator + 1}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Row(
              children: [
                buildDeleteButton(),
                SizedBox(width: MediaQuery.of(context).size.width/10,)
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
            child: Column(
              children: inputList,
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
            title: const Text(
              "Do you want to delete this Question?",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            content: Column(
              children: const [
                SizedBox(height: 10),
                Text(
                  "The deletion is irreversable",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                key: const ValueKey('deleteFaqQuestion'),
                isDestructiveAction: true,
                onPressed: () {
                  //Delete Faq Question
                  widget.notifyParents();
                  //pop dialog
                  Navigator.pop(context);
                },
                //child: const Text('Cancel Booking'),
                child: const Text("Delete"),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                //pop dialog
                onPressed: () => Navigator.pop(context),
                //child: const Text('Back'),
                child: const Text("Back"),
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
