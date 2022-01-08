import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/planner/header_widget.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';

List<Widget> buildHeader({required DateTime monday}) {
  List<Widget> headers = [];

  List<String> days = const ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"];
  DateTime today = extractDay(DateTime.now());

  for (int i = 0; i < 7; i++) {
    DateTime day = monday.add(Duration(days: i));

    PlannerHeader head = PlannerHeader(
      weekday: days[i],
      onPressed: () {
        CapacityService().addCapacity(
          Capacity(
            start: day.add(const Duration(hours: 8)),
            duration: const Duration(hours: 4),
            chairs: 4,
          ),
        );

        ProviderService().container.read(plannerUpdateProvider.state).state++;
      },
    );

    if (day.isAtSameMomentAs(today)) {
      headers.add(
        Container(
          color: Colors.yellow,
          child: head,
        ),
      );
    } else {
      headers.add(head);
    }
  }

  return headers;
}
