import 'package:flutter/material.dart';
import './lang_input.dart';

class QuestionTile extends StatefulWidget {
  final int iterator;
  final List<Map<String, List<String>>> data;
  final List<List<String>> lang;

  const QuestionTile({Key? key, required this.iterator, required this.data, required this.lang}) : super(key: key);

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  @override
  Widget build(BuildContext context) {
    

    List<Widget> inputList = [];
    for (int j = 0; j < widget.lang.length; j++) {
      inputList.add(LangInput(data: widget.data, country: widget.lang[j][0], iterator: widget.iterator, countryName: widget.lang[j][1]));
    }

    return ExpansionTile(
      key: ValueKey("Frage${widget.iterator + 1}"),
      title: Text(
        "Frage no. ${widget.iterator + 1}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      backgroundColor: widget.iterator % 2 == 0 ? Colors.white70 : Colors.white,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: inputList,
          ),
        ),
      ],
    );
  }
}