import 'package:flutter/material.dart';

/// The [CalendarTextStyle] is a model that defines the text style of the calendar.
///
/// If you want to specify a different style besides changing
/// the text style of the calendar,
/// use [CalendarStyle] instead of [CalendarTextStyle].
class CalendarTextStyle {
  /// The color of the normal date.
  ///
  /// It means the date when the item below was excluded.
  ///
  /// - Focused day
  /// - Selected day
  /// - Selected range day
  /// - Outside day
  final Color dayTextColor;

  /// The color of the focused day text.
  final Color focusedDayTextColor;

  /// The color of the selected day text.
  final Color selectedDayTextColor;

  /// The color of the selected range day text.
  final Color rangeDayTextColor;

  /// The color of the date text deviates
  /// from that month in the displayed calendar.
  final Color outsideDayTextColor;

  /// The color of the day of week text.
  final Color dayOfWeekTextColor;

  /// The font size of the day of week.
  final double? dayOfWeekFontSize;

  /// The font size of the dates.
  final double? dayFontSize;

  /// The font size of the calendar header.
  final TextStyle headerTextStyle;

  const CalendarTextStyle({
    this.dayTextColor = Colors.black,
    this.focusedDayTextColor = Colors.black,
    this.selectedDayTextColor = Colors.white,
    this.rangeDayTextColor = Colors.white,
    this.outsideDayTextColor = Colors.grey,
    this.dayOfWeekTextColor = Colors.black,
    this.dayOfWeekFontSize,
    this.dayFontSize,
    this.headerTextStyle = const TextStyle(
      fontSize: 17.0,
    ),
  });
}
