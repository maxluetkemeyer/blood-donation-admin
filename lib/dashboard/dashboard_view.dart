import 'package:blooddonation_admin/dashboard/patientoverview/patient_overview_widget.dart';
import 'package:blooddonation_admin/dashboard/workloadoverview/workload_overview_widget.dart';
import 'package:flutter/material.dart';

import 'requestsoverview/requests_overview_widget.dart';
import 'style.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(8),
            decoration: cardDecoration,
            child: const PatienOverview(),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: cardDecoration,
                    padding: const EdgeInsets.all(8),
                    child: const RequestsOverview(),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: cardDecoration,
                    padding: const EdgeInsets.all(8),
                    child: const WorkloadOverview(),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
