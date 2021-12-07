import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/services/settings_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Planner extends StatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  final DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime monday = getMonday(DateTime.now());

  bool changed = false;

  @override
  Widget build(BuildContext context) {
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
            headerTitles: buildHeaders(),
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

  List<Widget> buildHeaders() {
    List<String> days = const ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "sonntag"];

    //int weekday = DateTime.now().weekday;

    List<Widget> headers = [];

    for (String day in days) {
      headers.add(
        Column(
          children: [
            Text(day),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text("Zeitslot hinzufügen"),
              onPressed: () {
                SettingsService.instance.addCapacity(
                  Capacity(
                    start: DateTime.now(),
                    duration: const Duration(hours: 2),
                    chairs: 4,
                  ),
                );
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    return headers;
  }

  List<CoolCalendarEvent> buildEvents(DateTime monday) {
    SettingsService ss = SettingsService.instance;

    List<CoolCalendarEvent> events = [];

    for (int i = 0; i < 7; i++) {
      List<Capacity> dayEvents = ss.getCapacitiesPerDay(monday.add(Duration(days: i)));

      for (Capacity capacity in dayEvents) {
        events.add(
          CoolCalendarEvent(
            initTopMultiplier: capacity.start.hour * 2,
            initHeightMultiplier: (capacity.duration.inMinutes / 30).ceil(),
            rowIndex: i,
            onChange: (start, end) {
              capacity.start = DateTime(
                capacity.start.year,
                capacity.start.month,
                capacity.start.day,
                (start / 2).round(),
              );
              DateTime endDate = DateTime(
                capacity.start.year,
                capacity.start.month,
                capacity.start.day,
                (end / 2).round(),
              );
              capacity.duration = endDate.difference(capacity.start);
              setState(() {
                changed = true;
              });
            },
            decoration: const BoxDecoration(
              color: Color.fromRGBO(237, 152, 42, 1),
            ),
            child: Center(
              child: Text(capacity.chairs.toString() + " Stühle"),
            ),
          ),
        );
      }
    }

    return events;
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Save"),
    );
  }
}
