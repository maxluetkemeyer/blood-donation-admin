import 'package:blooddonation_admin/dashboard/requestsoverview/barchart.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestsOverview extends StatelessWidget {
  const RequestsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            barTitle(getMonday(DateTime.now())),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(), //Size backup
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
      ),
    );
  }
}

String barTitle(DateTime monday) {
  String mondayString = DateFormat("dd.MM.").format(monday);
  String sundayString = DateFormat("dd.MM.yyyy").format(monday.add(const Duration(days: 6)));

  return "Termine vom $mondayString - $sundayString";
}

Widget statistic(String head, String body, double fontSize) {
  return Column(
    children: [
      Text(
        head,
        style: TextStyle(
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),
      Text(
        body,
        style: TextStyle(
          fontSize: fontSize * 1.01,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
