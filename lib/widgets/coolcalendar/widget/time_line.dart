import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  final double hourHeight;

  const TimeLine({
    Key? key,
    required this.hourHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: timeBoxes(),
    );
  }

  List<Widget> timeBoxes() {
    SizedBox timeBox(String text) => SizedBox(
          width: double.infinity,
          height: hourHeight / 2,
          child: Transform.translate(
            offset: const Offset(0, -8),
            child: Text(text),
          ),
        );

    List<Widget> items = [];

    for (int i = 0; i < 24; i++) {
      String time = i < 10 ? "0$i" : "$i";

      items.add(timeBox("$time:00"));
      //items.add(timeBox("$time:30"));
      items.add(timeBox(""));
    }

    return items;
  }
}
