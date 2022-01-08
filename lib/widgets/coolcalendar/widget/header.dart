import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final List<Widget> headerTitles;
  final double timeLineWidth;
  final double eventGridEventWidth;

  const Header({
    Key? key,
    required this.headerTitles,
    required this.timeLineWidth,
    required this.eventGridEventWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (headerTitles.isEmpty) {
      return const SizedBox();
    }

    return Row(
      children: [
        SizedBox(
          width: timeLineWidth + 5,
        ),
        for (var item in headerTitles)
          SizedBox(
            width: eventGridEventWidth,
            child: item,
          ),
      ],
    );
  }
}
