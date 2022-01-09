import 'package:blooddonation_admin/dashboard/requestsoverview/barchart.dart';
import 'package:flutter/material.dart';

class RequestsOverview extends StatelessWidget {
  const RequestsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_left,
              size: 60,
              color: Colors.blueGrey.shade400,
            ),
            const Text(
              "Heute",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Icon(
              Icons.arrow_right,
              size: 60,
              color: Colors.blueGrey.shade400,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            statistic("Anfragen\ninsgesammt:", "10"),
            statistic("Anfragen\nbestätigt:", "10"),
            statistic("Anfragen\nabgelehnt:", "0"),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 4),
          child: Text(
            "Woche vom 03.01. - 09.01.2022",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const RequestWeekBarChart(),
      ],
    );
  }
}

Widget statistic(String head, String body) {
  return Column(
    children: [
      Text(
        head,
        style: const TextStyle(
          fontSize: 30,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),
      Text(
        body,
        style: const TextStyle(
          fontSize: 34,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
