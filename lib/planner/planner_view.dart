import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/planner/calendar/build_header.dart';
import 'package:blooddonation_admin/planner/header/headder_widget.dart';
import 'package:blooddonation_admin/services/backend/handlers/create_capacities.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          PlannerHeader(
            width: (width / 7 - 10) * 7,
            //width: (width / 9 - 10) * 4,
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
              discreteStepSize: 10,
              hourHeight: 40,
              eventGridEventWidth: width / 7 - 10,
              timeLineWidth: 56,
              headerTitles: buildHeader(monday: monday),
              events: buildEvents(monday),
              eventGridColor: const Color.fromRGBO(225, 245, 254, 1),
              eventGridLineColorHalfHour: const Color.fromRGBO(11, 72, 116, 0.06),
              eventGridLineColorFullHour: const Color.fromRGBO(11, 72, 116, 0.2),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              timeLineColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("UPLOAD CHANGES"),
        icon: const Icon(Icons.save),
        onPressed: () {
          CreateCapacitiesHandler().send();
        },
      ),
    );
  }
}
