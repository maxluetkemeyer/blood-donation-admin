import 'package:blooddonation_admin/dashboard/workloadoverview/workload_today.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:flutter/material.dart';

class WorkloadOverview extends StatelessWidget {
  const WorkloadOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WorkloadToday(
          key: const ValueKey("workload_today"),
          heading: "Auslastung heute",
          day: extractDay(DateTime.now()),
        ),
        WorkloadToday(
          key: const ValueKey("workload_tomorrow"),
          heading: "Auslastung morgen",
          day: extractDay(DateTime.now().add(const Duration(days: 1))),
        ),
      ],
    );
  }
}
