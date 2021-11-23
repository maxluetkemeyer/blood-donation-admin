import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';

class CalendarOverview extends StatefulWidget {
  const CalendarOverview({Key? key}) : super(key: key);

  @override
  _CalendarOverviewState createState() => _CalendarOverviewState();
}

class _CalendarOverviewState extends State<CalendarOverview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Create Appointment"),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("<"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("November 22-28, 2022"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(">"),
                ),
              ],
            )
          ],
        ),
        const Expanded(
          child: CoolCalendar(),
        ),
      ],
    );
  }
}
