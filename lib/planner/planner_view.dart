import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/planner/build_header.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'build_events.dart';

class Planner extends ConsumerStatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  ConsumerState<Planner> createState() => _PlannerState();
}

class _PlannerState extends ConsumerState<Planner> {
  final DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime monday = getMonday(DateTime.now());

  bool changed = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int update = ref.watch(plannerUpdateProvider.state).state;
    print("planner rebuild" + update.toString());
    return Column(
      children: [
        ExpansionPanelList.radio(
          children: [
            ExpansionPanelRadio(
              value: "value",
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                if (isExpanded) {
                  return Row(
                    children: [
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(left: 30),
                        child: TableCalendar(
                          focusedDay: monday,
                          firstDay: getMonday(DateTime.now()),
                          lastDay: getMonday(DateTime.now()).add(const Duration(days: 56)),
                          calendarFormat: CalendarFormat.week,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            headerPadding: EdgeInsets.all(0),
                          ),
                          onPageChanged: (focusedDay) {
                            print(getMonday(focusedDay));
                            setState(() {
                              monday = getMonday(focusedDay);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 200,
                      ),
                      const Text("Dauer eines Blutspendetermins: 1 Stunde"),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      if (changed) saveButton(),
                    ],
                  );
                }

                return Row(
                  children: [
                    const Text("Week"),
                    SizedBox(
                      width: 300,
                      child: TableCalendar(
                        focusedDay: monday,
                        firstDay: getMonday(DateTime.now()),
                        lastDay: getMonday(DateTime.now()).add(const Duration(days: 56)),
                        calendarFormat: CalendarFormat.week,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        daysOfWeekVisible: false,
                        headerVisible: false,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          headerPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    if (changed) saveButton(),
                  ],
                );
              },
              body: const SizedBox(),
            ),
          ],
        ),
        Expanded(
          child: CoolCalendar(
            discreteStepSize: 20,
            eventGridColor: const Color.fromRGBO(140, 208, 247, 1),
            headerTitles: buildHeader(),
            headerTitleDecoration: const BoxDecoration(
              color: Color.fromRGBO(227, 245, 255, 1),
              border: Border(
                right: BorderSide(
                  width: 1,
                ),
              ),
            ),
            events: buildEvents(monday),
          ),
        ),
      ],
    );
  }

  

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Save"),
    );
  }
}
