import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const SizedBox(
        width: 640,
        height: 360,
        child: HtmlElementView(
          viewType: "github-wiki",
        ),
      ),
    );
  }
}
