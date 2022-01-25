import 'package:blooddonation_admin/logging/eventlog/eventlog_widget.dart';
import 'package:blooddonation_admin/logging/statistic_row.dart';
import 'package:blooddonation_admin/logging/statistic_row_two.dart';
import 'package:blooddonation_admin/services/logging_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Text(
                  AppLocalizations.of(context)!.loggingStatistic,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Table(
                  border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 1),
                  children: <TableRow>[
                    statisticRow(
                        key: AppLocalizations.of(context)!.loggingStatisticNumberOfFirstTimeDonations,
                        value: LoggingService().statistic.numberOfFirstTimeDonations.toString()),
                    statisticRow(
                        key: AppLocalizations.of(context)!.loggingStatisticTotalBookedAppointments,
                        value: LoggingService().statistic.totalBookedAppointments.toString()),
                    statisticRow(
                      key: AppLocalizations.of(context)!.loggingStatisticAcceptedRequests,
                      value: LoggingService().statistic.acceptedRequests.toString(),
                    ),
                    statisticRow(
                      key: AppLocalizations.of(context)!.loggingStatisticRejectedRequests,
                      value: LoggingService().statistic.rejectedRequests.toString(),
                    ),
                    statisticRow(
                      key: AppLocalizations.of(context)!.loggingStatisticCancelledRequests,
                      value: LoggingService().statistic.cancelledRequests.toString(),
                    ),
                    statisticRowTwo(
                      key: AppLocalizations.of(context)!.loggingStatisticAged18To27,
                      value: LoggingService().statistic.aged18To27.toString(),
                      valueTwo: (LoggingService().statistic.aged18To27 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
                    ),
                    statisticRowTwo(
                      key: AppLocalizations.of(context)!.loggingStatisticAged28To37,
                      value: LoggingService().statistic.aged28To37.toString(),
                      valueTwo: (LoggingService().statistic.aged28To37 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
                    ),
                    statisticRowTwo(
                      key: AppLocalizations.of(context)!.loggingStatisticAged38To47,
                      value: LoggingService().statistic.aged38To47.toString(),
                      valueTwo: (LoggingService().statistic.aged38To47 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
                    ),
                    statisticRowTwo(
                      key: AppLocalizations.of(context)!.loggingStatisticAged48To57,
                      value: LoggingService().statistic.aged48To57.toString(),
                      valueTwo: (LoggingService().statistic.aged48To57 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
                    ),
                    statisticRowTwo(
                      key: AppLocalizations.of(context)!.loggingStatisticAged58To68,
                      value: LoggingService().statistic.aged58To68.toString(),
                      valueTwo: (LoggingService().statistic.aged58To68 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
