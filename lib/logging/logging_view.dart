import 'package:blooddonation_admin/logging/eventlog/eventlog_widget.dart';
import 'package:blooddonation_admin/logging/statistic_row.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoggingView extends ConsumerWidget {
  const LoggingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Eventlog(),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            color: Colors.lightGreen,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: <TableRow>[
                statisticRow(key: "Statistik 1", value: "234"),
                statisticRow(key: "Statistik 2", value: "4564"),
                statisticRow(key: "Statistik 3", value: "89464"),
                statisticRow(key: "Statistik 4", value: "78"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
