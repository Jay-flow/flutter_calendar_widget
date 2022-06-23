import 'package:flutter/material.dart';

/// [DataType] is a model that distinguishes the types of dates that are built.
@immutable
class DateType {
  /// Distinguishes whether the date is focused when the calendar first appears.
  final bool isFocused;

  /// Whether to select a date.
  final bool isSelected;

  /// Whether the date range selection excludes the start and end dates.
  final bool isRange;

  /// Whether the start date is when selecting a range
  final bool isRangeStart;

  /// Whether the end date is when selecting a range
  final bool isRangeEnd;

  /// Whether the date was selected when the date range was selected.
  /// Contains start and end dates.
  final bool isWithinRange;

  /// Whether the calendar displayed is out of date for that month.
  final bool isOutSide;

  const DateType({
    this.isFocused = false,
    this.isSelected = false,
    this.isRange = false,
    this.isRangeStart = false,
    this.isRangeEnd = false,
    this.isWithinRange = false,
    this.isOutSide = false,
  });
}
