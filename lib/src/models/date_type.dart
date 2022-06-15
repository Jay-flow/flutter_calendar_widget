import 'package:flutter/material.dart';

@immutable
class DateType {
  final bool isSelected;
  final bool isOutSide;

  const DateType({
    this.isSelected = false,
    this.isOutSide = false,
  });
}
