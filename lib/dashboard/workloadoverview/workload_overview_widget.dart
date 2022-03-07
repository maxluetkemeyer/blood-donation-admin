import 'package:blooddonation_admin/dashboard/workloadoverview/workload_today.dart';
import 'package:flutter/material.dart';

class WorkloadOverview extends StatelessWidget {
  const WorkloadOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        WorkloadToday(),
        WorkloadToday(),
      ],
    );
  }
}
