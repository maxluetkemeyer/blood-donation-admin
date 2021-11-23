import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';

class Tester extends StatelessWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoolCalendar(
        discreteStepSize: 24,
        headerTitles: const [
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
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            ballDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Hey"),
            ),
            onChange: (start, end) => print("start $start, end $end"),
          ),
          CoolCalendarEvent(
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            ballDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Hey"),
            ),
          ),
          CoolCalendarEvent(
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 2,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            ballDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text("Hey"),
            ),
          ),
        ],
      ),
    );
  }
}
