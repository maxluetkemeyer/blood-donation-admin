import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/planner/header_widget.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';

List<Widget> buildHeader() {
    List<Widget> headers = [];

    List<String> days = const ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"];
    int todayWeekDay = DateTime.now().weekday;
    DateTime today = extractDay(DateTime.now());

    for (int i = 1; i < 8; i++) {
      DateTime day = today.add(Duration(days: -todayWeekDay + i));

      headers.add(
        PlannerHeader(
          weekday: days[i - 1],
          onPressed: () {
            CapacityService.instance.addCapacity(
              Capacity(
                start: day.add(const Duration(hours: 8)),
                duration: const Duration(hours: 2),
                chairs: 4,
              ),
            );

            ProviderService.instance.container.read(plannerUpdateProvider.state).state++;
          },
        ),
      );
    }

    return headers;
  }