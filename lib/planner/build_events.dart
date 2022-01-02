import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/planner/chair_edit_widget.dart';
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
      events.add(
        CoolCalendarEvent(
          initTopMultiplier: capacity.start.hour * 2,
          initHeightMultiplier: (capacity.duration.inMinutes / 30).ceil(),
          rowIndex: i,
          onChange: (start, end) {
            capacity.start = DateTime(
              capacity.start.year,
              capacity.start.month,
              capacity.start.day,
              (start / 2).round(),
            );
            DateTime endDate = DateTime(
              capacity.start.year,
              capacity.start.month,
              capacity.start.day,
              (end / 2).round(),
            );
            capacity.duration = endDate.difference(capacity.start);
            /*setState(() {
                changed = true;
              });*/
            ProviderService().container.read(plannerUpdateProvider.state).state++;
          },
          decoration: const BoxDecoration(
            color: Color.fromRGBO(237, 152, 42, 1),
          ),
          child: Center(
              //child: Text(capacity.chairs.toString() + " Stühle"),
              child: ChairEdit(chairs: capacity.chairs)),
        ),
      );
    }
  }

  return events;
}
