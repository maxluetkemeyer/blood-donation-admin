import 'package:flutter/cupertino.dart';

///[LangInput] is a widget that generates two input and one [Text] Widget for one question and one language
class LangInput extends StatefulWidget {
  final List<Map<String, List<String>>> data;
  final String country;
  final int iterator;
  final String countryName;
  
  const LangInput({ Key? key , required this.data, required this.country, required this.iterator, required this.countryName}) : super(key: key);

  @override
  _LangInputState createState() => _LangInputState();
}

class _LangInputState extends State<LangInput> {
  @override
  Widget build(BuildContext context) {
    List<Widget> res = [
      Text(widget.countryName),
      CupertinoTextField(
        onChanged: (String input){
          widget.data[widget.iterator+1][widget.country]?[0] = input;
        },
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle
        ),
        placeholder: widget.data[widget.iterator][widget.country]?[0],
        prefix: const Text("Frage")
      ),
      CupertinoTextField(
        onChanged: (String input){
          widget.data[widget.iterator][widget.country]?[1] = input;
        },
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle
        ),
        placeholder: widget.data[widget.iterator][widget.country]?[1],
        prefix: const Text("Antwort"),
      ),
    ];
    return Column(children: res,);
  }
}