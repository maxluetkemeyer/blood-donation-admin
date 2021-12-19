import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarStyle calendarStyle(BuildContext context) => CalendarStyle(
    selectedDecoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
    ),
    weekendDecoration: const BoxDecoration(
      color: Colors.grey,
    ),
    outsideDecoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
    ),
    outsideTextStyle: const TextStyle(
      color: Colors.black,
    ),
    defaultDecoration: const BoxDecoration(
      color: Colors.white,
    ));

HeaderStyle calendarHeaderStyle(BuildContext context) => const HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      headerPadding: EdgeInsets.all(0),
    );

CalendarBuilders calendarBuilder = CalendarBuilders(
  defaultBuilder: (context, day, focusedDay) {
    day = day.toLocal().add(const Duration(hours: -1));
    int appointments = CalendarService().getAppointmentsPerDay(day).length;

    Color bgColor;
    if (appointments > 0) {
      bgColor = Colors.amber.shade100;
    } else {
      bgColor = Colors.white;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(6),
        color: bgColor,
        child: Text(day.day.toString()),
      ),
    );
  },
);

Color requestColor(String status) {
  switch (status) {
    case "pending":
      return Colors.amber.shade200;
    case "accepted":
      return Colors.lightGreen.shade200;
    case "declined":
      return Colors.deepOrange;
    default:
      return Colors.white;
  }
}
