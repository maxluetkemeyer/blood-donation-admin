import 'package:flutter/material.dart';

class GridLines extends StatelessWidget {
  final double hourHeight;
  final Color eventGridLineColorFullHour;
  final Color eventGridLineColorHalfHour;

  const GridLines({
    Key? key,
    required this.hourHeight,
    required this.eventGridLineColorFullHour,
    required this.eventGridLineColorHalfHour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: lines(),
    );
  }

  List<Widget> lines() {
    Container eventBox(Color color) => Container(
          width: double.infinity,
          height: hourHeight / 2,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: color,
              ),
            ),
          ),
        );

    List<Widget> items = [];

    for (int i = 0; i < 24; i++) {
      items.add(eventBox(eventGridLineColorFullHour));
      items.add(eventBox(eventGridLineColorHalfHour));
    }

    return items;
  }
}
