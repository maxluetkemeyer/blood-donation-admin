import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RequestWeekBarChart extends StatefulWidget {
  final DateTime monday;

  const RequestWeekBarChart({
    Key? key,
    required this.monday,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => RequestWeekBarChartState();
}

class RequestWeekBarChartState extends State<RequestWeekBarChart> {
  final Color barColorBottom = Colors.blue;
  final Color barColorTop = Colors.blue.shade100;
  final double barWidth = 30;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.8 / 1,
      child: BarChart(
        BarChartData(
          backgroundColor: Colors.transparent,
          borderData: FlBorderData(
            show: true,
            border: const Border(
              top: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
              bottom: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
          ),
          //fertig
          barGroups: buildBars(),
          gridData: FlGridData(),
          titlesData: FlTitlesData(
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              getTitles: (value) {
                switch (value.toInt()) {
                  case 0:
                    return "Montag";
                  case 1:
                    return "Dienstag";
                  case 2:
                    return "Mittwoch";
                  case 3:
                    return "Donnerstag";
                  case 4:
                    return "Freitag";
                  case 5:
                    return "Samstag";
                  case 6:
                    return "Sonntag";
                  default:
                    return "";
                }
              },
              showTitles: true,
            ),
          ),
          maxY: maxY(),
        ),
      ),
    );
  }

  List<BarChartGroupData> buildBars() {
    List<BarChartGroupData> bars = [];

    for (int i = 0; i < 7; i++) {
      int amountAppointments = CalendarService().getAppointmentsPerDay(widget.monday.add(Duration(days: i))).length;

      bars.add(
        BarChartGroupData(
          x: i,
          barRods: <BarChartRodData>[
            BarChartRodData(
              y: amountAppointments.toDouble(),
              borderRadius: const BorderRadius.all(Radius.zero),
              width: barWidth,
              colors: [
                barColorBottom,
                barColorTop,
              ],
            ),
          ],
        ),
      );
    }

    return bars;
  }

  double maxY() {
    int max = 50;

    for (int i = 0; i < 7; i++) {
      int amountAppointments = CalendarService().getAppointmentsPerDay(widget.monday.add(Duration(days: i))).length;

      if (amountAppointments > max) max = amountAppointments + 10;
    }

    return max.toDouble();
  }
}
