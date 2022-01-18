import 'package:flutter/material.dart';
import '../data/data.dart' as dates;
import '../widgets/question_tile.dart';

class FaqEditView extends StatefulWidget {
  const FaqEditView({Key? key}) : super(key: key);
  @override
  State<FaqEditView> createState() => _FaqEditViewState();
}

class _FaqEditViewState extends State<FaqEditView> {
  var data = dates.data;
  var lang = dates.lang;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faq Edit Settings"),
      ),
      body: Center(
        child: ReorderableListView(
          children: getQuestionTiles(data,lang),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              var item = data.removeAt(oldIndex);
              data.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }

  ///Returns a [List] of [QuestionTile]'s which are Expandable Tiles that allow the user to change FAQ questions
  List<QuestionTile> getQuestionTiles(List<Map<String, List<String>>> data, List<List<String>> lang) {
    List<QuestionTile> l = [];
    for(int i = 0; i < data.length;i++){
      l.add(QuestionTile(iterator: i,data: data,lang: lang,key: ValueKey("Frage$i"),));
    }
    return  l;
  }


  ///In this function, the field for [TextEditingController]'s is created. The generated pointer system has the same structure 
  ///as the data fetched from the server. Therefore both need to be managed and maintained.
  List<Map<String, List<TextEditingController>>> buildController(List<Map<String, List<String>>> data, List<List<String>> lang){
    List<Map<String, List<TextEditingController>>> res = [];
    for(int i = 0; i<data.length; i++){
      Map<String, List<TextEditingController>> cur = {};
      for(int j = 0; j<lang.length; j++){
        cur[lang[j][0]]=[TextEditingController(),TextEditingController()];
      }
      res.add(cur);
    }
    return res;
  }
}
