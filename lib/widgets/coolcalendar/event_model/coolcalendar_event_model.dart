import 'package:flutter/material.dart';

class CoolCalendarEvent {
  final Widget child;
  final int initTopMinutes;
  final int initHeightMinutes;
  final int rowIndex;
  final Decoration decoration;
  final Decoration decorationHover;
  final Decoration ballDecoration;
  final Function(int start, int length)? onChange;
  final bool dragging;
  final Function? onTap;

  CoolCalendarEvent({
    required this.child,
    required this.initTopMinutes,
    required this.initHeightMinutes,
    this.decoration = const BoxDecoration(),
    this.decorationHover = const BoxDecoration(),
    this.rowIndex = 0,
    this.ballDecoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    this.onChange,
    this.dragging = true,
    this.onTap,
  });

  CoolCalendarEvent copyWith({
    Widget? child,
    int? initTopMinutes,
    int? initHeightMinutes,
    Decoration? decoration,
    Decoration? decorationHover,
    int? rowIndex,
    Decoration? ballDecoration,
    Function(int start, int length)? onChange,
    bool? dragging,
  }) {
    return CoolCalendarEvent(
      child: child ?? this.child,
      initTopMinutes: initTopMinutes ?? this.initTopMinutes,
      initHeightMinutes: initHeightMinutes ?? this.initHeightMinutes,
      ballDecoration: ballDecoration ?? this.ballDecoration,
      decoration: decoration ?? this.decoration,
      decorationHover: decorationHover ?? this.decorationHover,
      dragging: dragging ?? this.dragging,
      onChange: onChange ?? this.onChange,
      rowIndex: rowIndex ?? this.rowIndex,
    );
  }
}
