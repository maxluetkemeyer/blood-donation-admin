import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String buttonText;
  final Widget nextPage;

  const SettingsButton({Key? key, required this.buttonText, required this.nextPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CupertinoButton.filled(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
          child: Text(buttonText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
