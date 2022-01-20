import 'package:blooddonation_admin/dashboard/requestsoverview/barchart.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            statistic("Anfragen\ninsgesamt:", "10"),
            statistic("Anfragen\nbestätigt:", "10"),
            statistic("Anfragen\nabgelehnt:", "0"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 4),
          child: Text(
            barTitle(getMonday(DateTime.now())),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SizedBox(
            width: 700,
            child: RequestWeekBarChart(
              monday: getMonday(DateTime.now()),
            ),
          ),
        ),
      ],
    );
  }
}

String barTitle(DateTime monday) {
  String mondayString = DateFormat("dd.MM.").format(monday);
  String sundayString = DateFormat("dd.MM.yyyy").format(monday.add(const Duration(days: 6)));

  return "Termine vom $mondayString - $sundayString";
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
