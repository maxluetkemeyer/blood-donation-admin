// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'drag_resize_event_widget.dart';

class DayView extends StatefulWidget {
  final int timeLineFlex;
  final int eventGridFlex;

  final List<CoolCalendarEvent> events;

  final Color backgroundColor = Colors.blue.shade200;
  final Color timeLineColor = Colors.amber.shade200;
  final Color dividerColor = Colors.black;
  final Color eventGridColor = Colors.green.shade200;

  final double discreteStepSize = 30;
  final Color lineColorFullHour = Colors.black54;
  final Color eventGridLineColorFullHour = Colors.black54;
  final Color eventGridLineColorHalfHour = Colors.black38;

  DayView({
    Key? key,
    this.timeLineFlex = 1,
    this.eventGridFlex = 10,
    this.events = const [],
  }) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(5),
        color: widget.backgroundColor,
        child: Row(
          children: [
            Flexible(
              flex: widget.timeLineFlex,
              fit: FlexFit.tight,
              child: Container(
                color: widget.timeLineColor,
                child: Column(
                  children: timeLine(),
                ),
              ),
            ),
            VerticalDivider(
              color: widget.dividerColor,
            ),
            Flexible(
              flex: widget.eventGridFlex,
              fit: FlexFit.tight,
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
          child: DragResizeEvent(
            discreteStepSize: widget.discreteStepSize,
            initHeightMultiplier: event.initHeightMultiplier,
            initTopMultiplier: event.initTopMultiplier,
            rowIndex: event.rowIndex,
            backgroundColor: event.backgroundColor,
            ballDecoration: event.ballDecoration,
            onChange: event.onChange,
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

class CoolCalendarEvent {
  final Widget child;
  final int initTopMultiplier;
  final int initHeightMultiplier;
  final int rowIndex;
  final Color backgroundColor;
  final BoxDecoration ballDecoration;
  final Function(double start, double end) onChange;

  CoolCalendarEvent({
    required this.child,
    required this.initTopMultiplier,
    required this.initHeightMultiplier,
    required this.backgroundColor,
    this.rowIndex = 0,
    this.ballDecoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    required this.onChange,
  });
}
