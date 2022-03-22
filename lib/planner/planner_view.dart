import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/planner/calendar/build_header.dart';
import 'package:blooddonation_admin/planner/functions/copy_previous_week.dart';
import 'package:blooddonation_admin/planner/functions/delete_this_week.dart';
import 'package:blooddonation_admin/planner/functions/reload_from_server.dart';
import 'package:blooddonation_admin/planner/header/headder_widget.dart';
import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:blooddonation_admin/widgets/expandable_fab/expandable_fab_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'calendar/build_events.dart';

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

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int update = ref.watch(plannerUpdateProvider.state).state;
    bool changed = ref.watch(plannerChangedProvider.state).state;

    double width = MediaQuery.of(context).size.width;
    bool previousWeekAvaiable = (monday.add(const Duration(days: -7)).isBefore(getMonday(today)));

    return Scaffold(
      body: Column(
        children: [
          PlannerHeader(
            width: (width / 7 - 10) * 7,
            monday: monday,
            onTableCalendarPageChange: (focusedDay) {
              print(getMonday(focusedDay));
              setState(() {
                monday = getMonday(focusedDay);
              });
            },
          ),
          Expanded(
            child: CoolCalendar(
              key: const PageStorageKey("planner_view"),
              eventGridEventWidth: width / 7 - 10,
              timeLineWidth: 56,
              headerTitles: buildHeader(monday: monday),
              events: buildEvents(monday),
              eventGridLineColorHalfHour: Colors.transparent,
              eventGridLineColorFullHour: const Color.fromRGBO(11, 72, 116, 0.2),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (changed)
            FloatingActionButton.extended(
              label: const Text("ÄNDERUNGEN SPEICHERN"),
              icon: const Icon(Icons.save),
              onPressed: () {
                CreateCapacitiesHandler().send();
              },
            ),
          const SizedBox(width: 10),
          ExpandableFab(
            distance: 20,
            children: [
              //from top to bottom
              FloatingActionButton.extended(
                label: const Text("Vom Server neu laden"),
                icon: const Icon(Icons.refresh),
                onPressed: () => reloadFromServer(),
              ),
              FloatingActionButton.extended(
                label: const Text("Nächste Woche"),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => setState(() {
                  monday = monday.add(const Duration(days: 7));
                }),
              ),
              FloatingActionButton.extended(
                label: const Text("Vorherige Woche"),
                icon: const Icon(Icons.arrow_back),
                backgroundColor: previousWeekAvaiable ? Colors.grey : Theme.of(context).primaryColor,
                onPressed: previousWeekAvaiable
                    ? null
                    : () => setState(() {
                          monday = monday.add(const Duration(days: -7));
                        }),
              ),
              FloatingActionButton.extended(
                label: const Text("Vorherige Woche kopieren"),
                icon: const Icon(Icons.copy_all_outlined),
                onPressed: () => copyPreviousWeek(monday),
              ),
              FloatingActionButton.extended(
                label: const Text("Diese Woche leeren"),
                icon: const Icon(Icons.delete_sweep_rounded),
                onPressed: () => deleteThisWeek(monday),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
