import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarBuilders plannerCalendarBuilder(DateTime monday) => CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {
        day = day.toLocal().add(const Duration(hours: -1));
        bool isPlanned = CapacityService().getCapacitiesPerDay(day).isNotEmpty;

        BoxDecoration decoration = BoxDecoration(
          color: Colors.blueGrey.shade50,
        );

        //selected week days
        if (day.isAtSameMomentAs(monday) || day.isAfter(monday) && day.isBefore(monday.add(const Duration(days: 7)))) {
          decoration = BoxDecoration(
            color: Colors.green.shade50,
            border: const Border.symmetric(
              horizontal: BorderSide(
                width: 2,
                color: Colors.green,
              ),
            ),
          );
        }

        //days with capacities
        if (isPlanned) {
          decoration = decoration.copyWith(
            color: Colors.amber.shade100,
          );
        }

        //past days
        if (day.isBefore(extractDay(DateTime.now()))) {
          //decoration = const BoxDecoration();
        }

        //today
        if (day.isAtSameMomentAs(extractDay(DateTime.now()))) {
          decoration = decoration.copyWith(
            color: Colors.pink.shade200,
          );
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            alignment: Alignment.center,
            decoration: decoration,
            child: Text(day.day.toString()),
          ),
        );
      },
    );

CalendarBuilders plannerCalendarClosedBuilder(DateTime monday) => CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {
        day = day.toLocal().add(const Duration(hours: -1));
        bool isPlanned = CapacityService().getCapacitiesPerDay(day).isNotEmpty;

        BoxDecoration decoration = BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: const Border.symmetric(
            vertical: BorderSide(
              width: 1,
            ),
          ),
        );

        //days with capacities
        if (isPlanned) {
          decoration = decoration.copyWith(
            color: Colors.amber.shade100,
          );
        }

        //past days
        if (day.isBefore(extractDay(DateTime.now()))) {
          decoration = const BoxDecoration(
            color: Colors.black,
          );
        }

        //today
        if (day.isAtSameMomentAs(extractDay(DateTime.now()))) {
          decoration = decoration.copyWith(
            color: Colors.pink.shade200,
          );
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            alignment: Alignment.center,
            decoration: decoration,
            child: Text(DateFormat("dd.MM.yyyy").format(day)),
          ),
        );
      },
    );
