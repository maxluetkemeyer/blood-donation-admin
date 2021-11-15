import 'package:flutter/material.dart';

class DragResizeEvent extends StatefulWidget {
  final Widget child;
  final Function(double start, double end) onChange;
  final Color backgroundColor;

  final double discreteStepSize;
  final int initHeightMultiplier;
  final int initTopMultiplier;
  final double width;
  final int rowIndex;

  final double ballDiameter;
  final BoxDecoration ballDecoration;

  const DragResizeEvent({
    Key? key,
    required this.discreteStepSize,
    required this.initHeightMultiplier,
    required this.initTopMultiplier,
    required this.rowIndex,
    required this.backgroundColor,
    this.child = const SizedBox(),
    this.ballDiameter = 20.0,
    this.width = 180,
    required this.ballDecoration,
    required this.onChange,
  }) : super(key: key);

  @override
  _DragResizeEventState createState() => _DragResizeEventState();
}

class _DragResizeEventState extends State<DragResizeEvent> {
  late double height;
  late double top;

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
          child: Container(
            height: height,
            width: widget.width,
            color: widget.backgroundColor,
            child: widget.child,
          ),
        ),
        // ###################################### Top controll
        Positioned(
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
                  height = newHeight > 30 ? newHeight : 30;
                  if (newHeight < 30) return;

                  var newTop = top - widget.discreteStepSize;
                  top = newTop > 0 ? newTop : 0;
                });
              } else if (cumulativeDy <= -widget.discreteStepSize) {
                setState(() {
                  cumulativeDy = 0;

                  var newHeight = height - widget.discreteStepSize;
                  height = newHeight > 30 ? newHeight : 30;
                  if (newHeight < 30) return;

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
        ),
        // ###################################### Bottom controll
        Positioned(
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
                  height = newHeight > 30 ? newHeight : 30;
                  cumulativeDy = 0;
                });
              } else if (cumulativeDy <= -widget.discreteStepSize) {
                setState(() {
                  var newHeight = height - widget.discreteStepSize;
                  height = newHeight > 30 ? newHeight : 30;
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
        ),
        // ###################################### Dragger
        Positioned(
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
