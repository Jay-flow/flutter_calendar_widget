import 'package:flutter/material.dart';

@immutable
class DateType {
  final bool isFocused;
  final bool isSelected;
  final bool isRange;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
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
