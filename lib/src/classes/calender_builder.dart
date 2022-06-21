import 'package:flutter/material.dart';

import '../../flutter_calendar_widget.dart';
import '../models/calender_style.dart';
import '../widgets/empty.dart';

abstract class CalenderBuilder {
  final CalenderStyle style = CalenderStyle();

  Widget build(
    DateTime dateTime,
    DateType type,
    List events,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        type.isWithinRange
            ? LayoutBuilder(builder: (context, constraints) {
                return buildRangeLine(type, constraints);
              })
            : const Empty(),
        buildDay(dateTime, type),
        events.isNotEmpty ? buildEvents(events) : const Empty(),
      ],
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

  Widget buildEvents(List events) {
    return Positioned(
      bottom: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: events
            .take(5)
            .map(
              (e) => Container(
                height: 5,
                width: 5,
                margin: const EdgeInsets.symmetric(horizontal: 0.5),
                decoration: const BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  shape: BoxShape.circle,
                ),
              ),
            )
            .toList(),
      ),
    );
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
