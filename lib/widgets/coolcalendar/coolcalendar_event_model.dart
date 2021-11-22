import 'package:flutter/material.dart';

class CoolCalendarEvent {
  final Widget child;
  final int initTopMultiplier;
  final int initHeightMultiplier;
  final int rowIndex;
  final Color backgroundColor;
  final BoxDecoration ballDecoration;
  final Function(double start, double end)? onChange;
  final bool dragging;

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
    this.onChange,
    this.dragging = true,
  });
}
