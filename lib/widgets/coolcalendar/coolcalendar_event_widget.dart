import 'package:flutter/material.dart';

class CoolCalendarEventWidget extends StatefulWidget {
  final Widget child;
  final Function(double start, double end) onChange;
  final Function onTap;
  final Decoration decoration;
  final Decoration decorationHover;
  final bool animated;

  final double discreteStepSize;
  final int initHeightMultiplier;
  final int initTopMultiplier;
  final double width;
  final int rowIndex;

  final double ballDiameter;
  final Decoration ballDecoration;
  final bool dragging;

  const CoolCalendarEventWidget({
    Key? key,
    required this.discreteStepSize,
    required this.initHeightMultiplier,
    required this.initTopMultiplier,
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
  _CoolCalendarEventWidgetState createState() =>
      _CoolCalendarEventWidgetState();
}

class _CoolCalendarEventWidgetState extends State<CoolCalendarEventWidget> {
  late double height;
  late double top;
  bool onHover = false;

  double cumulativeDy = 0;
  double cumulativeDx = 0;
  double cumulativeMid = 0;

  @override
  void initState() {
    super.initState();

    top = widget.initTopMultiplier * widget.discreteStepSize;
    height = widget.initHeightMultiplier * widget.discreteStepSize;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
                      decoration:
                          onHover ? widget.decorationHover : widget.decoration,
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
        // ###################################### Top controll
        widget.dragging
            ? Positioned(
                top: top - widget.ballDiameter / 2,
                left: widget.width * widget.rowIndex +
                    widget.width / 2 -
                    widget.ballDiameter / 2,
                child: _Dragger(
                  onEnd: (_) => widget.onChange(top, top + height),
                  onDrag: (dx, dy) {
                    cumulativeDy -= dy;
                    if (cumulativeDy >= widget.discreteStepSize) {
                      setState(() {
                        cumulativeDy = 0;

                        var newHeight = height + widget.discreteStepSize;
                        height = newHeight > widget.discreteStepSize
                            ? newHeight
                            : widget.discreteStepSize;
                        if (newHeight < widget.discreteStepSize) return;

                        var newTop = top - widget.discreteStepSize;
                        top = newTop > 0 ? newTop : 0;
                      });
                    } else if (cumulativeDy <= -widget.discreteStepSize) {
                      setState(() {
                        cumulativeDy = 0;

                        var newHeight = height - widget.discreteStepSize;
                        height = newHeight > widget.discreteStepSize
                            ? newHeight
                            : widget.discreteStepSize;
                        if (newHeight < widget.discreteStepSize) return;

                        var newTop = top + widget.discreteStepSize;
                        top = newTop > 0 ? newTop : 0;
                      });
                    }
                  },
                  child: Container(
                    width: widget.ballDiameter,
                    height: widget.ballDiameter,
                    decoration: widget.ballDecoration,
                  ),
                ),
              )
            : const SizedBox(),
        // ###################################### Bottom controll
        widget.dragging
            ? Positioned(
                top: top + height - widget.ballDiameter / 2,
                left: widget.width * widget.rowIndex +
                    widget.width / 2 -
                    widget.ballDiameter / 2,
                child: _Dragger(
                  onEnd: (_) => widget.onChange(top, top + height),
                  onDrag: (dx, dy) {
                    cumulativeDy += dy;

                    if (cumulativeDy >= widget.discreteStepSize) {
                      setState(() {
                        var newHeight = height + widget.discreteStepSize;
                        height = newHeight > widget.discreteStepSize
                            ? newHeight
                            : widget.discreteStepSize;
                        cumulativeDy = 0;
                      });
                    } else if (cumulativeDy <= -widget.discreteStepSize) {
                      setState(() {
                        var newHeight = height - widget.discreteStepSize;
                        height = newHeight > widget.discreteStepSize
                            ? newHeight
                            : widget.discreteStepSize;
                        cumulativeDy = 0;
                      });
                    }
                  },
                  child: Container(
                    width: widget.ballDiameter,
                    height: widget.ballDiameter,
                    decoration: widget.ballDecoration,
                  ),
                ),
              )
            : const SizedBox(),
        // ###################################### Dragger
        widget.dragging
            ? Positioned(
                top: top + 0.5 * widget.ballDiameter,
                left: widget.width * widget.rowIndex,
                child: _Dragger(
                  onEnd: (_) => widget.onChange(top, top + height),
                  onDrag: (dx, dy) {
                    cumulativeDy -= dy;
                    if (cumulativeDy >= widget.discreteStepSize) {
                      setState(() {
                        var newTop = top - widget.discreteStepSize;
                        top = newTop > 0 ? newTop : 0;

                        cumulativeDy = 0;
                      });
                    } else if (cumulativeDy <= -widget.discreteStepSize) {
                      setState(() {
                        var newTop = top + widget.discreteStepSize;
                        top = newTop > 0 ? newTop : 0;

                        cumulativeDy = 0;
                      });
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: (height - 1 * widget.ballDiameter) > 0
                        ? height - 1 * widget.ballDiameter
                        : 0,
                    width: widget.width,
                  ),
                ),
              )
            : const SizedBox(),
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
