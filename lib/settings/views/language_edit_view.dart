import 'package:blooddonation_admin/settings/widgets/new_language.dart';
import 'package:flutter/material.dart';

class LanguageEditView extends StatefulWidget {
  const LanguageEditView({Key?key}): super(key: key);

  @override
  State<LanguageEditView> createState() => _LanguageEditViewState();
}

class _LanguageEditViewState extends State<LanguageEditView> {
  
  //TODO: Funktionsweise für Backend hinzufügen
  var languageList = ["Deutsch", "English"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Settings"),
      ),
      body: Center(
          //const Text("List of all Languages"),
          child: ListView(
        children: getLanguageWidgets(languageList),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return NewLanguage(languages: languageList,);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> getLanguageWidgets(List<String> languages) {
    List<Widget> result = [];
    if(languages.isEmpty){
      return [const Text("Füge Sprachen hinzu, um dem User neue Sprachanzeigen zu ermöglichen")];
    }
    for (int i = 0; i < languages.length; i++) {
      result.add(Card(
        color: i%2==0?Colors.white70:Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(languages[i]),
            SizedBox(width: MediaQuery.of(context).size.width / 5),
            IconButton(
                onPressed: () {
                  setState(() {
                    languages.removeAt(i);
                  });
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ));
      result.add(const Divider());
    }

    return result;
  }
}
