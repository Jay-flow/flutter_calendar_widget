import 'package:flutter/material.dart';

class CalenderTextStyle {
  final Color dayTextColor;
  final Color focusedDayTextColor;
  final Color selectedDayTextColor;
  final Color rangeDayTextColor;
  final Color outsideDayTextColor;
  final Color dayOfWeekTextColor;

  final double? dayOfWeekFontSize;
  final double? dayFontSize;

  const CalenderTextStyle({
    this.dayTextColor = Colors.black,
    this.focusedDayTextColor = Colors.black,
    this.selectedDayTextColor = Colors.white,
    this.rangeDayTextColor = Colors.white,
    this.outsideDayTextColor = Colors.grey,
    this.dayOfWeekTextColor = Colors.black,
    this.dayOfWeekFontSize,
    this.dayFontSize,
  });
}
