import 'package:flutter/material.dart';

import 'event_model/coolcalendar_event_model.dart';
import 'widget/event_stack.dart';
import 'widget/header.dart';
import 'widget/time_line.dart';

export 'event_model/coolcalendar_event_model.dart';

class CoolCalendar extends StatefulWidget {
  /// Height of one minute
  final double minuteHeight;

  final Decoration? timeLineDecoration;

  /// Width of the time line.
  final double timeLineWidth;

  /// All events which will be displayed.
  final List<CoolCalendarEvent> events;

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
    this.eventGridLineColorFullHour = Colors.black38,
    this.eventGridLineColorHalfHour = Colors.transparent,
    this.eventGridEventWidth = 220,
    this.headerTitles = const [],
    this.scrollController,
    this.animated = false,
    this.minuteHeight = 2,
    this.timeLineDecoration,
    this.timeLineWidth = 50,
  }) : super(key: key);

  @override
  _CoolCalendarState createState() => _CoolCalendarState();
}

class _CoolCalendarState extends State<CoolCalendar> {
  double eventGridEventWidth = 0;

  @override
  void initState() {
    super.initState();
    eventGridEventWidth = widget.eventGridEventWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              child: Slider(
                value: eventGridEventWidth,
                min: 20,
                max: 500,
                onChanged: (double value) => setState(() {
                  eventGridEventWidth = value;
                }),
              ),
            ),
          ],
        ),
        Header(
          eventGridEventWidth: eventGridEventWidth,
          headerTitles: widget.headerTitles,
          timeLineWidth: widget.timeLineWidth,
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController ?? ScrollController(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.timeLineWidth / 7.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TimeLine(
                    minuteHeight: widget.minuteHeight,
                    decoration: widget.timeLineDecoration,
                    timeLineWidth: widget.timeLineWidth,
                  ),
                  Expanded(
                    child: EventStack(
                      animated: widget.animated,
                      eventGridEventWidth: eventGridEventWidth,
                      eventGridLineColorFullHour: widget.eventGridLineColorFullHour,
                      eventGridLineColorHalfHour: widget.eventGridLineColorHalfHour,
                      events: widget.events,
                      hourHeight: widget.minuteHeight * 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
