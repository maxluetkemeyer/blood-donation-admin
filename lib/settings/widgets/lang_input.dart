import 'package:blooddonation_admin/services/settings/models/faq_controller_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:flutter/cupertino.dart';

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
    List<Widget> res = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.countryName,
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        ),
      ),
      CupertinoTextField(
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        placeholder: widget.data[widget.iterator][widget.country]?.question,
        prefix: const Text(
          "Frage",
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        controller: widget.controllers[widget.iterator][widget.country]?.questionController,
      ),
      CupertinoTextField(
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        placeholder: widget.data[widget.iterator][widget.country]?.question,
        prefix: const Text(
          "Antwort",
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        controller: widget.controllers[widget.iterator][widget.country]?.answerController,
      ),
    ];
    return Column(
      children: res,
    );
  }
}
