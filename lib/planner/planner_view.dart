import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/planner/build_header.dart';
import 'package:blooddonation_admin/planner/headder_widget.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    double width = MediaQuery.of(context).size.width;

    return Column(
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
            discreteStepSize: 10,
            hourHeight: 40,
            eventGridColor: const Color.fromRGBO(140, 208, 247, 1),
            eventGridEventWidth: width / 7 - 10,
            timeLineWidth: 56,
            headerTitles: buildHeader(monday: monday),
            eventGridLineColorHalfHour: Colors.grey,
            events: buildEvents(monday),
          ),
        ),
      ],
    );
  }
}
