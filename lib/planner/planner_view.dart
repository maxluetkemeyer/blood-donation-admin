import 'package:blooddonation_admin/widgets/day_view/day_view_widget.dart';
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
    return DayView(
      events: [
        CoolCalendarEvent(
          child: const SizedBox(),
          initTopMultiplier: 16,
          initHeightMultiplier: 20,
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}
