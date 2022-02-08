import 'package:flutter/material.dart';

import 'package:blooddonation_admin/widgets/coolcalendar/event_model/coolcalendar_event_model.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/event_widget/coolcalendar_event_widget.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/widget/grid_lines.dart';

class EventStack extends StatelessWidget {
  final double hourHeight;
  final Color eventGridLineColorFullHour;
  final Color eventGridLineColorHalfHour;
  final double eventGridEventWidth;
  final bool animated;
  final List<CoolCalendarEvent> events;

  const EventStack({
    Key? key,
    required this.hourHeight,
    required this.eventGridLineColorFullHour,
    required this.eventGridLineColorHalfHour,
    required this.eventGridEventWidth,
    required this.animated,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children(),
    );
  }

  List<Widget> children() {
    List<Widget> stack = [];

    stack.add(
      GridLines(
        hourHeight: hourHeight,
        eventGridLineColorFullHour: eventGridLineColorFullHour,
        eventGridLineColorHalfHour: eventGridLineColorHalfHour,
      ),
    );

    for (CoolCalendarEvent event in events) {
      stack.add(
        Positioned.fill(
          child: CoolCalendarEventWidget(
            initHeightMinutes: event.initHeightMinutes,
            initTopMinutes: event.initTopMinutes,
            rowIndex: event.rowIndex,
            decoration: event.decoration,
            decorationHover: event.decorationHover,
            ballDecoration: event.ballDecoration,
            onChange: event.onChange ?? (_, __) {},
            onTap: event.onTap ?? () {},
            width: eventGridEventWidth,
            dragging: event.dragging,
            animated: animated,
            hourHeight: hourHeight,
            child: event.child,
          ),
        ),
      );
    }

    return stack;
  }
}
