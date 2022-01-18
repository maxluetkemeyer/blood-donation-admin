import 'package:blooddonation_admin/planner/header/accordion_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/planner/header/calendar_builder.dart';

class PlannerHeader extends StatefulWidget {
  final DateTime monday;
  final Function(DateTime focusedDay) onTableCalendarPageChange;
  final double width;

  const PlannerHeader({
    Key? key,
    required this.monday,
    required this.onTableCalendarPageChange,
    required this.width,
  }) : super(key: key);

  @override
  State<PlannerHeader> createState() => _PlannerHeaderState();
}

class _PlannerHeaderState extends State<PlannerHeader> {
  late DateTime focusedDay;
  bool isExpanded = false;

  @override
  void initState() {
    focusedDay = widget.monday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isExpanded = !isExpanded;
      }),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Accordion(
          open: isExpanded,
          onButtonTap: () => setState(() {
            isExpanded = !isExpanded;
          }),
          closedWidget: Row(
            children: [
              const SizedBox(
                width: 61, //timeline width + 5 padding
                height: 10,
              ),
              SizedBox(
                width: widget.width,
                child: TableCalendar(
                  focusedDay: widget.monday,
                  firstDay: getMonday(DateTime.now()),
                  lastDay: widget.monday.add(const Duration(days: 70)),
                  calendarFormat: CalendarFormat.week,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: false,
                  headerVisible: false,
                  onDaySelected: (_, __) => setState(() {
                    isExpanded = !isExpanded;
                    print("hi");
                  }),
                  onDisabledDayTapped: (_) => setState(() {
                    isExpanded = !isExpanded;
                    print("hi2");
                  }),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    headerPadding: EdgeInsets.all(0),
                  ),
                  calendarBuilders: plannerCalendarClosedBuilder(widget.monday),
                  calendarStyle: const CalendarStyle(
                    isTodayHighlighted: false,
                  ),
                ),
              ),
            ],
          ),
          openWidget: Padding(
            padding: const EdgeInsets.only(left: 100, right: 100, bottom: 40),
            child: TableCalendar(
              focusedDay: focusedDay,
              firstDay: getMonday(DateTime.now()),
              lastDay: getMonday(DateTime.now()).add(const Duration(days: 365 * 2)),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                headerPadding: const EdgeInsets.all(0),
                leftChevronIcon: Container(
                  width: 200,
                  height: 40,
                  color: Colors.black,
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                  ),
                ),
                rightChevronIcon: Container(
                  width: 200,
                  height: 40,
                  color: Colors.black,
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              calendarBuilders: plannerCalendarBuilder(widget.monday),
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
              ),
              onPageChanged: (focusedDay) {
                setState(() {
                  this.focusedDay = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                widget.onTableCalendarPageChange(selectedDay);
              },
              onHeaderTapped: (_) => setState(() {
                isExpanded = !isExpanded;
              }),
            ),
          ),
        ),
      ),
    );
  }
}
