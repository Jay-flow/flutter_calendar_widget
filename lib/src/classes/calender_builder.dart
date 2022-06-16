import 'package:flutter/material.dart';

import '../models/date_type.dart';
import '../widgets/empty.dart';

abstract class CalenderBuilder {
  final double defaultWidth;
  final double defaultHeight;

  CalenderBuilder({
    this.defaultWidth = 30,
    this.defaultHeight = 50,
  });

  Widget build(DateTime dateTime, DateType type) {
    if (type.isSelected) {
      return buildSelectedDay(dateTime, type);
    }
    if (type.isRange) {
      return buildRangeDay(dateTime, type);
    }
    if (type.isFocused) {
      return buildFocusedDay(dateTime, type);
    }

    return buildDefaultDay(dateTime, type);
  }

  Widget buildSelectedDay(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        Container(
          color: Colors.black,
        ),
        _buildDayText(dateTime, type),
      ],
    );
  }

  Widget buildRangeDay(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        Container(
          color: Colors.grey[300],
        ),
        _buildDayText(dateTime, type),
      ],
    );
  }

  Widget buildFocusedDay(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.black),
          ),
        ),
        _buildDayText(dateTime, type),
      ],
    );
  }

  Widget buildDefaultDay(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        const Empty(),
        _buildDayText(dateTime, type),
      ],
    );
  }

  Widget _buildDayText(DateTime dateTime, DateType type) {
    return Text(
      dateTime.day.toString(),
      style: TextStyle(
        color: _getDayTextColor(type),
      ),
    );
  }

  Color _getDayTextColor(DateType type) {
    // TODO:: Apply dark theme color
    if (type.isSelected) {
      return Colors.white;
    }
    if (type.isOutSide) {
      return Colors.grey;
    }

    return Colors.black;
  }

  Widget _wrapStack({required List<Widget> children}) {
    return SizedBox(
      width: defaultWidth,
      height: defaultHeight,
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
  }
}
