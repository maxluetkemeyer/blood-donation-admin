import 'package:blooddonation_admin/misc/env.dart' as env;
import 'package:flutter/material.dart';

class CoolCalendarEventWidget extends StatefulWidget {
  final Widget child;
  final Function(int start, int length) onChange;
  final Function onTap;
  final Decoration decoration;
  final Decoration decorationHover;
  final bool animated;

  final double hourHeight;

  final int initHeightMinutes;
  final int initTopMinutes;
  final double width;
  final int rowIndex;

  final double ballDiameter;
  final Decoration ballDecoration;
  final bool dragging;

  const CoolCalendarEventWidget({
    Key? key,
    required this.hourHeight,
    required this.initHeightMinutes,
    required this.initTopMinutes,
    required this.rowIndex,
    required this.decoration,
    required this.decorationHover,
    this.child = const SizedBox(),
    this.ballDiameter = 20.0,
    required this.width,
    required this.ballDecoration,
    required this.onChange,
    required this.dragging,
    required this.animated,
    required this.onTap,
  }) : super(key: key);

  @override
  _CoolCalendarEventWidgetState createState() => _CoolCalendarEventWidgetState();
}

class _CoolCalendarEventWidgetState extends State<CoolCalendarEventWidget> {
  late double height;
  late double top;
  late double discreteStepSize;
  bool onHover = false;

  double cumulativeDy = 0;
  double cumulativeDx = 0;
  double cumulativeMid = 0;

  @override
  void initState() {
    super.initState();

    discreteStepSize = widget.hourHeight / (60 / env.APPOINTMENT_LENGTH_IN_MINUTES);

    top = widget.initTopMinutes * (widget.hourHeight / 60);
    height = widget.initHeightMinutes * (widget.hourHeight / 60);
  }

  @override
  Widget build(BuildContext context) {
    print("new: " + top.toString() + " " + height.toString());
    return Stack(
      children: <Widget>[
        // ###################################### Top controll
        if (widget.dragging)
          Positioned(
            top: top - widget.ballDiameter / 2,
            left: widget.width * widget.rowIndex + widget.width / 2 - widget.ballDiameter / 2,
            child: _Dragger(
              onEnd: (_) => widget.onChange(top ~/ (widget.hourHeight / 60), height ~/ (widget.hourHeight / 60)),
              onDrag: (dx, dy) {
                cumulativeDy -= dy;
                if (cumulativeDy >= discreteStepSize) {
                  //drag upwards
                  setState(() {
                    cumulativeDy = 0;
                    //border
                    if (top == 0) return;
                    //new position
                    top = top - discreteStepSize;
                    //increase height
                    height = height + discreteStepSize;
                  });
                } else if (cumulativeDy <= -discreteStepSize) {
                  //drag downwards
                  setState(() {
                    cumulativeDy = 0;
                    //border
                    if (height == discreteStepSize) return;
                    //new position
                    top = top + discreteStepSize;
                    //decrease height
                    height = height - discreteStepSize;
                  });
                }
              },
              child: Container(
                width: widget.ballDiameter,
                height: widget.ballDiameter,
                decoration: widget.ballDecoration,
              ),
            ),
          ),
        // ###################################### Bottom controll
        if (widget.dragging)
          Positioned(
            top: top + height - widget.ballDiameter / 2,
            left: widget.width * widget.rowIndex + widget.width / 2 - widget.ballDiameter / 2,
            child: _Dragger(
              onEnd: (_) => widget.onChange(top ~/ (widget.hourHeight / 60), height ~/ (widget.hourHeight / 60)),
              onDrag: (dx, dy) {
                cumulativeDy += dy;
                if (cumulativeDy >= discreteStepSize) {
                  //drag downwards
                  setState(() {
                    cumulativeDy = 0;
                    //bottom border
                    if (top + height == widget.hourHeight * 24) return;
                    //decrease height
                    height = height + discreteStepSize;
                  });
                } else if (cumulativeDy <= -discreteStepSize) {
                  //drag upwards
                  setState(() {
                    cumulativeDy = 0;
                    //border
                    if (height == discreteStepSize) return;
                    //increase height
                    height = height - discreteStepSize;
                  });
                }
              },
              child: Container(
                width: widget.ballDiameter,
                height: widget.ballDiameter,
                decoration: widget.ballDecoration,
              ),
            ),
          ),
        // ###################################### Child
        Positioned(
          top: top,
          left: widget.width * widget.rowIndex,
          child: MouseRegion(
            onEnter: (_) => setState(() {
              onHover = true;
            }),
            onExit: (_) => setState(() {
              onHover = false;
            }),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.onTap(),
              child: widget.animated
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: height,
                      width: widget.width,
                      decoration: onHover ? widget.decorationHover : widget.decoration,
                      child: widget.child,
                    )
                  : Container(
                      height: height,
                      width: widget.width,
                      decoration: widget.decoration,
                      child: widget.child,
                    ),
            ),
          ),
        ),
        // ###################################### Dragger
        if (widget.dragging)
          Positioned(
            top: top + 0.5 * widget.ballDiameter,
            left: widget.width * widget.rowIndex,
            child: _Dragger(
              onEnd: (_) => widget.onChange(top ~/ (widget.hourHeight / 60), height ~/ (widget.hourHeight / 60)),
              onDrag: (dx, dy) {
                cumulativeDy -= dy;
                if (cumulativeDy >= discreteStepSize) {
                  setState(() {
                    cumulativeDy = 0;
                    //border
                    if (top == 0) return;
                    //new position
                    top = top - discreteStepSize;
                  });
                } else if (cumulativeDy <= -discreteStepSize) {
                  setState(() {
                    cumulativeDy = 0;
                    //bottom border
                    if (top + height == widget.hourHeight * 24) return;
                    top = top + discreteStepSize;
                  });
                }
              },
              child: Container(
                color: Colors.transparent,
                height: (height - 1 * widget.ballDiameter) > 0 ? height - 1 * widget.ballDiameter : 0,
                width: widget.width,
              ),
            ),
          ),
      ],
    );
  }
}

class _Dragger extends StatefulWidget {
  final Function onDrag;
  final Widget child;
  final Function(DragEndDetails) onEnd;

  const _Dragger({
    Key? key,
    required this.onDrag,
    required this.child,
    required this.onEnd,
  }) : super(key: key);

  @override
  _DraggerState createState() => _DraggerState();
}

class _DraggerState extends State<_Dragger> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      onPanEnd: widget.onEnd,
      child: widget.child,
    );
  }
}
