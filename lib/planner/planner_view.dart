import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class Planner extends StatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  DateTime now = DateTime.now();
  DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return const WeekView(
      backgroundColor: Colors.blue,
      timeLineWidth: 100,
      
    );
  }
}
