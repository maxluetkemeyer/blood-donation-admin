import 'package:blooddonation_admin/widgets/day_view/day_view_widget.dart';
import 'package:flutter/material.dart';

class Tester extends StatelessWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DayView(
        events: [
          CoolCalendarEvent(
            initHeightMultiplier: 4,
            initTopMultiplier: 16,
            rowIndex: 0,
            backgroundColor: Theme.of(context).primaryColor,
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
            backgroundColor: Theme.of(context).primaryColor,
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
            backgroundColor: Theme.of(context).primaryColor,
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
