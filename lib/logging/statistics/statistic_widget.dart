import 'package:blooddonation_admin/services/logging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'statistic_row.dart';
import 'statistic_row_two.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              value: LoggingService().statistic.aged18to27.toString(),
              valueTwo: (LoggingService().statistic.aged18to27 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
            ),
            statisticRowTwo(
              key: AppLocalizations.of(context)!.loggingStatisticAged28To37,
              value: LoggingService().statistic.aged28to37.toString(),
              valueTwo: (LoggingService().statistic.aged28to37 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
            ),
            statisticRowTwo(
              key: AppLocalizations.of(context)!.loggingStatisticAged38To47,
              value: LoggingService().statistic.aged38to47.toString(),
              valueTwo: (LoggingService().statistic.aged38to47 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
            ),
            statisticRowTwo(
              key: AppLocalizations.of(context)!.loggingStatisticAged48To57,
              value: LoggingService().statistic.aged48to57.toString(),
              valueTwo: (LoggingService().statistic.aged48to57 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
            ),
            statisticRowTwo(
              key: AppLocalizations.of(context)!.loggingStatisticAged58To68,
              value: LoggingService().statistic.aged58to68.toString(),
              valueTwo: (LoggingService().statistic.aged58to68 / LoggingService().statistic.totalBookedAppointments).toString() + "%",
            ),
          ],
        ),
      ],
    );
  }
}
