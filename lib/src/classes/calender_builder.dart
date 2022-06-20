import 'package:flutter/material.dart';

import '../../flutter_calendar_widget.dart';
import '../models/calender_style.dart';
import '../widgets/empty.dart';

abstract class CalenderBuilder {
  final CalenderStyle style = CalenderStyle();

  Widget build(
    DateTime dateTime,
    DateType type,
  ) {
    return Padding(
      padding: style.daysRowVerticalPadding,
      child: type.isWithinRange
          ? Stack(
              alignment: Alignment.center,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return buildRangeLine(type, constraints);
                }),
                buildDay(dateTime, type),
              ],
            )
          : buildDay(dateTime, type),
    );
  }

  Widget buildRangeLine(DateType type, BoxConstraints constraints) {
    if (type.isRangeStart) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: constraints.maxWidth / 2,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: style.rangeLineColor),
            color: style.rangeLineColor,
          ),
        ),
      );
    }
    if (type.isRangeEnd) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: constraints.maxWidth / 2,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: style.rangeLineColor),
            color: style.rangeLineColor,
          ),
        ),
      );
    }
    if (type.isRange) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0, color: style.rangeLineColor),
          color: style.rangeLineColor,
        ),
      );
    }

    return const Empty();
  }

  Widget buildDay(DateTime dateTime, DateType type) {
    if (type.isSelected) {
      return buildSelectedDay(dateTime, type);
    }
    if (type.isRange) {
      return buildRangeDay(dateTime, type);
    }
    if (type.isRangeStart) {
      return buildRangeStart(dateTime, type);
    }
    if (type.isRangeEnd) {
      return buildRangeEnd(dateTime, type);
    }
    if (type.isFocused) {
      return buildFocusedDay(dateTime, type);
    }

    return buildDefaultDay(dateTime, type);
  }

  Widget buildDayOfWeek(DateTime dateTime, String weekdayString) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(child: Text(weekdayString)),
    );
  }

  Widget buildSelectedDay(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        _buildDayText(dateTime, type),
      ],
    );
  }

  Widget buildRangeDay(DateTime dateTime, DateType type) {
    return Center(child: _buildDayText(dateTime, type));
  }

  Widget buildRangeStart(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        _buildDayText(dateTime, type),
      ],
    );
  }

  Widget buildRangeEnd(DateTime dateTime, DateType type) {
    return _wrapStack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
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
            shape: BoxShape.circle,
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
    if (type.isSelected || type.isRangeStart || type.isRangeEnd) {
      return Colors.white;
    }
    if (type.isOutSide) {
      return Colors.grey;
    }

    return Colors.black;
  }

  Widget _wrapStack({required List<Widget> children}) {
    return Stack(
      alignment: Alignment.center,
      children: children,
    );
  }
}
