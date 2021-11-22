import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
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
    return CoolCalendar(
      headerTitles: [
        "Montag",
        "Dienstag",
        "Mittwoch",
        "Donnerstag",
        "Freitag",
        "Samstag",
        "Sonntag",
      ],
      events: [
        CoolCalendarEvent(
          child: const SizedBox(),
          initTopMultiplier: 16,
          initHeightMultiplier: 20,
          backgroundColor: Colors.blue,
        ),
        CoolCalendarEvent(
          child: const SizedBox(),
          initTopMultiplier: 16,
          initHeightMultiplier: 24,
          backgroundColor: Colors.blue,
          rowIndex: 2,
        ),
        CoolCalendarEvent(
          child: const SizedBox(),
          initTopMultiplier: 16,
          initHeightMultiplier: 20,
          backgroundColor: Colors.blue,
          rowIndex: 3,
        ),
      ],
    );
  }
}
