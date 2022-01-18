import 'package:flutter/material.dart';

class NewLanguage extends StatefulWidget {
  final List<String> languages;
  
  const NewLanguage({ Key? key ,required this.languages}) : super(key: key);

  @override
  State<NewLanguage> createState() => _NewLanguageState();
}

class _NewLanguageState extends State<NewLanguage> {
  final TextEditingController _textEditingController = TextEditingController(text: "New Language");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: _textEditingController,
            ),
            const SizedBox(height: 30,),
            IconButton(
              onPressed: (){
                setState(() {
                  widget.languages.add(_textEditingController.text);
                  print(widget.languages);
                  Navigator.of(context).pop();
                });
              }, 
              icon: const Icon(Icons.save)
            )
          ],
        ),
      ),
    );
  }
}