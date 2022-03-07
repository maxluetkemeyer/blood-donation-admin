import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/misc/env.dart' as env;
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class WorkloadToday extends StatefulWidget {
  const WorkloadToday({Key? key}) : super(key: key);

  @override
  State<WorkloadToday> createState() => _WorkloadTodayState();
}

class _WorkloadTodayState extends State<WorkloadToday> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double usage = _usagePercent();
    double free = 100.0 - usage;
    double sectionSpace = usage > 95 || usage < 5 ? 0 : 5;

    double size = MediaQuery.of(context).size.width * 0.06;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Auslastung heute",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(
          width: size * 2.02,
          height: size * 2.02,
          child: PieChart(
            PieChartData(
              sections: <PieChartSectionData>[
                PieChartSectionData(
                  value: usage,
                  radius: size,
                  color: Colors.blue,
                  showTitle: touchedIndex == 0 ? true : false,
                  titlePositionPercentageOffset: 0.6,
                  title: "$usage%",
                  titleStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                PieChartSectionData(
                  value: free,
                  radius: size,
                  color: Colors.blue.shade100,
                  showTitle: touchedIndex == 1 ? true : false,
                  titlePositionPercentageOffset: 0.6,
                  title: "$free%",
                  titleStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
              centerSpaceRadius: 0,
              startDegreeOffset: -90,
              sectionsSpace: sectionSpace,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Indicator(
              color: Colors.blue,
              text: "Termine bestätigt",
              isSquare: true,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.015),
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

  double _usagePercent() {
    int appointments = CalendarService().getAppointmentsPerDay(extractDay(DateTime.now())).length;

    int freeAppointments = 0;
    List<Capacity> capacities = CapacityService().getCapacitiesPerDay(DateTime.now());
    for (Capacity capacity in capacities) {
      int a = capacity.duration.inMinutes ~/ env.APPOINTMENT_LENGTH_IN_MINUTES;
      int b = a * capacity.slots;

      freeAppointments = freeAppointments + b;
    }

    //TODO: Bug when 100.0 is returned => Legend (Row Widget) does not get painted
    if (freeAppointments == 0) return 99.9;

    return ((appointments / freeAppointments) * 100).roundToDouble();
  }
}
