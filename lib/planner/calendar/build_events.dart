import 'package:blooddonation_admin/planner/calendar/slotedit_widget.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';

List<CoolCalendarEvent> buildEvents(DateTime monday) {
  CapacityService ss = CapacityService();

  List<CoolCalendarEvent> events = [];

  for (int i = 0; i < 7; i++) {
    List<Capacity> dayEvents = ss.getCapacitiesPerDay(monday.add(Duration(days: i)));

    for (Capacity capacity in dayEvents) {
      int topMinutes = Duration(
        hours: capacity.start.hour,
        minutes: capacity.start.minute,
      ).inMinutes;

      events.add(
        CoolCalendarEvent(
          initTopMinutes: topMinutes,
          initHeightMinutes: capacity.duration.inMinutes,
          rowIndex: i,
          onChange: (int topMinutes, int heightMinutes) {
            capacity.start = DateTime(
              capacity.start.year,
              capacity.start.month,
              capacity.start.day,
            ).add(Duration(minutes: topMinutes));

            capacity.duration = Duration(minutes: heightMinutes);
            if (!ProviderService().container.read(plannerChangedProvider.state).state) {
              ProviderService().container.read(plannerChangedProvider.state).state = true;
            }
          },
          decoration: const BoxDecoration(
            color: Color.fromRGBO(11, 72, 116, 1),
          ),
          child: SlotEdit(
            capacity: capacity,
          ),
        ),
      );
    }
  }

  return events;
}
