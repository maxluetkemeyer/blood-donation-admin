import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RequestWeekBarChart extends StatefulWidget {
  const RequestWeekBarChart({
    Key? key,
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
      aspectRatio: 3.5 / 1,
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
          barGroups: <BarChartGroupData>[
            //fertig
            createBar(
              x: 0,
              y: 40,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
            createBar(
              x: 1,
              y: 30,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
            createBar(
              x: 2,
              y: 10,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
            createBar(
              x: 3,
              y: 20,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
            createBar(
              x: 4,
              y: 30,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
            createBar(
              x: 5,
              y: 0,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
            createBar(
              x: 6,
              y: 0,
              barWidth: barWidth,
              barColorBottom: barColorBottom,
              barColorTop: barColorTop,
            ),
          ],
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
          maxY: 50,
        ),
      ),
    );
  }
}

BarChartGroupData createBar({
  required int x,
  required double y,
  required double barWidth,
  required Color barColorBottom,
  required Color barColorTop,
}) =>
    BarChartGroupData(
      x: x,
      //fertig
      barRods: <BarChartRodData>[
        //fertig
        BarChartRodData(
          y: y,
          borderRadius: const BorderRadius.all(Radius.zero),
          width: barWidth,
          colors: [
            barColorBottom,
            barColorTop,
          ],
        ),
      ],
    );
