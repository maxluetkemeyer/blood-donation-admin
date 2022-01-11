import 'package:blooddonation_admin/dashboard/workloadoverview/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WorkloadOverview extends StatefulWidget {
  const WorkloadOverview({Key? key}) : super(key: key);

  @override
  State<WorkloadOverview> createState() => _WorkloadOverviewState();
}

class _WorkloadOverviewState extends State<WorkloadOverview> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //const SizedBox(height: 10),
        const Text(
          "Auslastung heute",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(
          width: 230,
          height: 230,
          child: PieChart(
            PieChartData(
              sections: <PieChartSectionData>[
                PieChartSectionData(
                  value: 80,
                  radius: 100,
                  color: Colors.blue,
                  showTitle: touchedIndex == 0 ? true : false,
                  titlePositionPercentageOffset: 0.6,
                  title: "80%",
                  titleStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                PieChartSectionData(
                  value: 20,
                  radius: 100,
                  color: Colors.blue.shade100,
                  showTitle: touchedIndex == 1 ? true : false,
                  titlePositionPercentageOffset: 0.6,
                  title: "20%",
                  titleStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
              centerSpaceRadius: 0,
              startDegreeOffset: -90,
              sectionsSpace: 5,
              pieTouchData: PieTouchData(
                enabled: true,
                touchCallback: (FlTouchEvent flTouchEvent, PieTouchResponse? pieTouchResponse) {
                  setState(() {
                    if (!flTouchEvent.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Indicator(
              color: Colors.blue,
              text: "Termine bestätigt",
              isSquare: true,
            ),
            const SizedBox(width: 40),
            Indicator(
              color: Colors.blue.shade100,
              text: "Termine frei",
              isSquare: true,
            ),
          ],
        ),
      ],
    );
  }
}
