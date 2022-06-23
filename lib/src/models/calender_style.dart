import 'package:flutter/material.dart';

/// The [CalendarStyle] is a model that defines the style of the calendar.
///
/// If you want to define a text style for the calendar,
/// use [CalendarTextStyle] instead of [CalendarStyle].
class CalendarStyle {
  /// Widget that moves the previous calendar in the calendar header.
  final Widget headerLeftIcon;

  /// Widgets to move the next calendar in the calendar header.
  final Widget headerRightIcon;

  /// The color of the circle that is the background when selecting the range.
  final Color markerColor;

  /// The color of the line displayed when selecting the range.
  final Color rangeLineColor;

  /// The color of the dot where the event is displayed.
  final Color eventColor;

  /// The margin of the calendar header.
  final EdgeInsetsGeometry? headerMargin;

  /// The margin of the day of the week.
  final EdgeInsetsGeometry? dayOfWeekMargin;

  /// The margin of the calendar excluding the header.
  final EdgeInsetsGeometry? calenderMargin;

  /// The padding of the header.
  final EdgeInsets headerPadding;

  /// The padding of the calendar excluding the header.
  final EdgeInsets? calenderPadding;

  /// The padding of the calendar row.
  ///
  /// These values affect the appearance of the line when selecting a range date.
  /// It is recommended that you specify only vertical values.
  final EdgeInsets daysRowPadding;

  /// The padding for the day of the week.
  final EdgeInsets dayOfWeekPadding;

  /// The margin between dots where events are displayed.
  final EdgeInsets eventMargin;

  /// The alignment of the dates.
  final Alignment dayAlignment;

  /// The alignment of the dates.
  final Alignment dayOfWeekAlignment;

  /// The alignment day of week.
  final Alignment eventAlignment;

  //// The height of the calendar row.
  final double daysRowHeight;

  /// The border width of the focused day.
  final double focusedDayBorderWidth;

  /// The size of the displayed event dot.
  final double eventSize;

  /// The size of the background circle mark displayed when selecting a date.
  final double? markerSize;

  /// The maximum number that the event dot can display.
  ///
  /// If -1 is given, there is no limit.
  final int eventCounts;

  const CalendarStyle({
    this.headerLeftIcon = const Icon(
      Icons.chevron_left_outlined,
    ),
    this.headerRightIcon = const Icon(
      Icons.chevron_right_outlined,
    ),
    this.markerColor = Colors.black,
    this.rangeLineColor = Colors.grey,
    this.eventColor = Colors.deepOrangeAccent,
    this.headerMargin,
    this.dayOfWeekMargin,
    this.calenderMargin,
    this.headerPadding = const EdgeInsets.all(8.0),
    this.calenderPadding,
    this.daysRowPadding = const EdgeInsets.symmetric(vertical: 5),
    this.dayOfWeekPadding = const EdgeInsets.only(bottom: 10),
    this.eventMargin = const EdgeInsets.symmetric(
      horizontal: 0.7,
      vertical: 6,
    ),
    this.dayAlignment = Alignment.center,
    this.dayOfWeekAlignment = Alignment.center,
    this.eventAlignment = Alignment.bottomCenter,
    this.daysRowHeight = 52,
    this.focusedDayBorderWidth = 1,
    this.eventSize = 5,
    this.markerSize,
    this.eventCounts = 4,
  });
}
