import 'package:flutter/material.dart';

class CalenderStyle {
  final Widget headerLeftIcon;
  final Widget headerRightIcon;

  final Color rangeCircleColor;
  final Color rangeLineColor;
  final Color rangeLineDarkColor;
  final Color eventColor;

  final TextStyle headerTextStyle;

  final EdgeInsets headerPadding;
  final EdgeInsets daysRowPadding;
  final EdgeInsets dayOfWeekPadding;
  final EdgeInsets eventMargin;

  final Alignment dayAlignment;
  final Alignment dayOfWeekAlignment;
  final Alignment eventAlignment;

  final double focusedDayWidth;
  final double eventSize;
  final double? markerSize;

  final int eventCounts;

  const CalenderStyle({
    this.headerLeftIcon = const Icon(
      Icons.chevron_left_outlined,
    ),
    this.headerRightIcon = const Icon(
      Icons.chevron_right_outlined,
    ),
    this.rangeCircleColor = Colors.black,
    this.rangeLineColor = Colors.grey,
    this.rangeLineDarkColor = Colors.tealAccent,
    this.eventColor = Colors.deepOrangeAccent,
    this.headerTextStyle = const TextStyle(
      fontSize: 17.0,
    ),
    this.headerPadding = const EdgeInsets.all(8.0),
    this.daysRowPadding = const EdgeInsets.symmetric(vertical: 5),
    this.dayOfWeekPadding = const EdgeInsets.only(bottom: 10),
    this.eventMargin = const EdgeInsets.symmetric(
      horizontal: 0.7,
      vertical: 6,
    ),
    this.dayAlignment = Alignment.center,
    this.dayOfWeekAlignment = Alignment.center,
    this.eventAlignment = Alignment.bottomCenter,
    this.focusedDayWidth = 1,
    this.eventSize = 5,
    this.markerSize,
    this.eventCounts = 4,
  });
}
