import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/planner/calendar/build_header.dart';
import 'package:blooddonation_admin/planner/functions/copy_previous_week.dart';
import 'package:blooddonation_admin/planner/functions/delete_this_week.dart';
import 'package:blooddonation_admin/planner/header/headder_widget.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_capacities.dart';
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

  bool changed = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int update = ref.watch(plannerUpdateProvider.state).state;
    changed = ref.watch(plannerChangedProvider.state).state;

    double width = MediaQuery.of(context).size.width;

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
              key: GlobalKey(),
              hourHeight: 40,
              eventGridEventWidth: width / 7 - 10,
              timeLineWidth: 56,
              headerTitles: buildHeader(monday: monday),
              events: buildEvents(monday),
              eventGridColor: const Color.fromRGBO(225, 245, 254, 1),
              eventGridLineColorHalfHour: Colors.transparent,
              eventGridLineColorFullHour: const Color.fromRGBO(11, 72, 116, 0.2),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              timeLineColor: Theme.of(context).scaffoldBackgroundColor,
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
              label: const Text("UPLOAD CHANGES"),
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
                label: const Text("Next week"),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => setState(() {
                  monday = monday.add(const Duration(days: 7));
                }),
              ),
              FloatingActionButton.extended(
                label: const Text("Pevious week"),
                icon: const Icon(Icons.arrow_back),
                backgroundColor: (monday.add(const Duration(days: -7)).isBefore(today)) ? Colors.grey : Theme.of(context).primaryColor,
                onPressed: (monday.add(const Duration(days: -7)).isBefore(today))
                    ? null
                    : () => setState(() {
                          monday = monday.add(const Duration(days: -7));
                        }),
              ),
              FloatingActionButton.extended(
                label: const Text("Copy previous week"),
                icon: const Icon(Icons.copy_all_outlined),
                onPressed: () {
                  copyPreviousWeek(monday);
                  _update();
                },
              ),
              FloatingActionButton.extended(
                label: const Text("Clear this week"),
                icon: const Icon(Icons.delete_sweep_rounded),
                onPressed: () {
                  deleteThisWeek(monday);
                  _update();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _update() {
    if (ProviderService().container.read(plannerChangedProvider.state).state) {
      ProviderService().container.read(plannerUpdateProvider.state).state++;
    } else {
      ProviderService().container.read(plannerChangedProvider.state).state = true;
    }
  }
}
