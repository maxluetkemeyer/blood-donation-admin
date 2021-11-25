import 'package:flutter/material.dart';

class CoolCalendarEvent {
  final Widget child;
  final int initTopMultiplier;
  final int initHeightMultiplier;
  final int rowIndex;
  final Decoration decoration;
  final Decoration decorationHover;
  final Decoration ballDecoration;
  final Function(double start, double end)? onChange;
  final bool dragging;

  CoolCalendarEvent({
    required this.child,
    required this.initTopMultiplier,
    required this.initHeightMultiplier,
    this.decoration = const BoxDecoration(),
    this.decorationHover = const BoxDecoration(),
    this.rowIndex = 0,
    this.ballDecoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    this.onChange,
    this.dragging = true,
  });

  CoolCalendarEvent copyWith({
    Widget? child,
    int? initTopMultiplier,
    int? initHeightMultiplier,
    Decoration? decoration,
    Decoration? decorationHover,
    int? rowIndex,
    Decoration? ballDecoration,
    Function(double start, double end)? onChange,
    bool? dragging,
  }) {
    return CoolCalendarEvent(
      child: child ?? this.child,
      initTopMultiplier: initTopMultiplier ?? this.initTopMultiplier,
      initHeightMultiplier: initHeightMultiplier ?? this.initHeightMultiplier,
      ballDecoration: ballDecoration ?? this.ballDecoration,
      decoration: decoration ?? this.decoration,
      decorationHover: decorationHover ?? this.decorationHover,
      dragging: dragging ?? this.dragging,
      onChange: onChange ?? this.onChange,
      rowIndex: rowIndex ?? this.rowIndex,
    );
  }
}
