import 'package:flutter/material.dart';

@immutable
class DateType {
  final bool isFocused;
  final bool isSelected;
  final bool isRange;
  final bool isOutSide;

  const DateType({
    this.isFocused = false,
    this.isSelected = false,
    this.isRange = false,
    this.isOutSide = false,
  });
}
