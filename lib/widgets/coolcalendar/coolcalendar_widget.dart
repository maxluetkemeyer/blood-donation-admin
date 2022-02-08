import 'package:flutter/material.dart';

import 'event_model/coolcalendar_event_model.dart';
import 'widget/event_stack.dart';
import 'widget/header.dart';
import 'widget/time_line.dart';

export 'event_model/coolcalendar_event_model.dart';

class CoolCalendar extends StatefulWidget {
  /// All events which will be displayed.
  final List<CoolCalendarEvent> events;

  /// Color in the Background of the Calendar.
  /// Use eventGridColor or timeLineColor for specific styling.
  final Color backgroundColor;

  /// Height of one hour
  final double hourHeight;

  /// Width of the time line.
  final double timeLineWidth;

  /// Background color of the time line.
  final Color timeLineColor;

  /// Background color of the event grid.
  final Color eventGridColor;

  /// Gridline color of full hours.
  final Color eventGridLineColorFullHour;

  /// Gridline color of half hours.
  final Color eventGridLineColorHalfHour;

  /// Width of events in the event grid.
  final double eventGridEventWidth;

  /// List of header widgets, which will be shown over the calendar.
  final List<Widget> headerTitles;

  final ScrollController? scrollController;
  final bool animated;

  const CoolCalendar({
    Key? key,
    this.events = const [],
    this.backgroundColor = Colors.white,
    this.timeLineColor = Colors.white,
    this.eventGridColor = Colors.lightBlueAccent,
    required this.hourHeight,
    this.eventGridLineColorFullHour = Colors.black38,
    this.eventGridLineColorHalfHour = Colors.transparent,
    this.eventGridEventWidth = 220,
    this.headerTitles = const [],
    this.timeLineWidth = 50,
    this.scrollController,
    this.animated = false,
  }) : super(key: key);

  @override
  _CoolCalendarState createState() => _CoolCalendarState();
}

class _CoolCalendarState extends State<CoolCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            eventGridEventWidth: widget.eventGridEventWidth,
            headerTitles: widget.headerTitles,
            timeLineWidth: widget.timeLineWidth,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController ?? ScrollController(),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 5,
                  right: 10,
                  top: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      color: widget.timeLineColor,
                      width: widget.timeLineWidth,
                      child: TimeLine(
                        hourHeight: widget.hourHeight,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: widget.eventGridColor,
                        child: EventStack(
                          animated: widget.animated,
                          eventGridEventWidth: widget.eventGridEventWidth,
                          eventGridLineColorFullHour: widget.eventGridLineColorFullHour,
                          eventGridLineColorHalfHour: widget.eventGridLineColorHalfHour,
                          events: widget.events,
                          hourHeight: widget.hourHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
