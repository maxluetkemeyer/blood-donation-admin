import 'package:blooddonation_admin/logging/eventlog/eventlog_widget.dart';
import 'package:blooddonation_admin/logging/statistics/statistic_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoggingView extends ConsumerWidget {
  const LoggingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: const [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Eventlog(),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: StatisticWidget(),
          ),
        ),
      ],
    );
  }
}
