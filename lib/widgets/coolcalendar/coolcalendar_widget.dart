import 'package:flutter/material.dart';

import 'coolcalendar_event_widget.dart';
import 'coolcalendar_event_model.dart';

export 'coolcalendar_event_model.dart';

class CoolCalendar extends StatefulWidget {
  /// All events which will be displayed.
  final List<CoolCalendarEvent> events;

  /// Color in the Background of the Calendar.
  /// Use eventGridColor or timeLineColor for specific styling.
  final Color backgroundColor;

  /// Height of the time steps.
  final double discreteStepSize;

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

  /// List of header titels, which will be shown over the calendar.
  final List<String> headerTitles;

  /// Decoration of every header title box.
  final Decoration headerTitleDecoration;

  /// Textstyle of the header title.
  final TextStyle headerTextStyle;

  CoolCalendar({
    Key? key,
    this.events = const [],
    this.backgroundColor = Colors.white,
    this.timeLineColor = Colors.white,
    this.eventGridColor = Colors.lightBlueAccent,
    this.discreteStepSize = 30,
    this.eventGridLineColorFullHour = Colors.black38,
    this.eventGridLineColorHalfHour = Colors.transparent,
    this.eventGridEventWidth = 220,
    this.headerTitles = const [],
    this.headerTitleDecoration = const BoxDecoration(),
    this.headerTextStyle = const TextStyle(),
    this.timeLineWidth = 50,
  }) : super(key: key);

  @override
  _CoolCalendarState createState() => _CoolCalendarState();
}

class _CoolCalendarState extends State<CoolCalendar> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.only(
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
                      child: Column(
                        children: timeLine(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: widget.eventGridColor,
                        child: Stack(
                          children: buildEventStack(),
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

  Widget header() {
    if (widget.headerTitles.length == 0) {
      return SizedBox();
    }

    return Container(
      height: 30,
      child: Row(
        children: [
          SizedBox(
            width: widget.timeLineWidth + 5,
          ),
          for (var item in widget.headerTitles)
            Container(
              decoration: widget.headerTitleDecoration,
              alignment: Alignment.center,
              width: widget.eventGridEventWidth,
              child: Text(
                item,
                style: widget.headerTextStyle,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> buildEventStack() {
    List<Widget> stack = [];

    stack.add(
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: eventGrid(),
        ),
      ),
    );

    for (CoolCalendarEvent event in widget.events) {
      stack.add(
        Positioned.fill(
          child: CoolCalendarEventWidget(
            discreteStepSize: widget.discreteStepSize,
            initHeightMultiplier: event.initHeightMultiplier,
            initTopMultiplier: event.initTopMultiplier,
            rowIndex: event.rowIndex,
            backgroundColor: event.backgroundColor,
            ballDecoration: event.ballDecoration,
            onChange: event.onChange ?? (_, __) {},
            width: widget.eventGridEventWidth,
            dragging: event.dragging,
            child: event.child,
          ),
        ),
      );
    }

    return stack;
  }

  List<Widget> timeLine() {
    SizedBox timeBox(String text) => SizedBox(
          width: double.infinity,
          height: widget.discreteStepSize,
          child: Transform.translate(
            offset: Offset(0, -8),
            child: Text(text),
          ),
        );

    List<Widget> items = [];

    for (int i = 0; i < 24; i++) {
      String time = i < 10 ? "0$i" : "$i";

      items.add(timeBox("$time:00"));
      items.add(timeBox("$time:30"));
    }

    return items;
  }

  List<Widget> eventGrid() {
    Container eventBox(Color color) => Container(
          width: double.infinity,
          height: widget.discreteStepSize,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: color,
              ),
            ),
          ),
        );

    List<Widget> items = [];

    for (int i = 0; i < 24; i++) {
      items.add(eventBox(widget.eventGridLineColorFullHour));
      items.add(eventBox(widget.eventGridLineColorHalfHour));
    }

    return items;
  }
}
