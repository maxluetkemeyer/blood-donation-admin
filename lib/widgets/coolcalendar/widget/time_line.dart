import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  final double minuteHeight;
  final double timeLineWidth;
  final Decoration? decoration;

  const TimeLine({
    Key? key,
    required this.minuteHeight,
    required this.timeLineWidth,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = timeLineWidth / 2.5;

    return Container(
      decoration: decoration,
      padding: EdgeInsets.only(
        right: fontSize / 3,
      ),
      child: Column(
        children: [
          for (int i = 0; i < 24; i++)
            SizedBox(
              height: minuteHeight * 30,
              child: Transform.translate(
                offset: Offset(0, -fontSize / 2),
                child: Text(
                  i < 10 ? "0$i:00" : "$i:00",
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
