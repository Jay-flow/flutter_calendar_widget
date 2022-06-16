import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/models/date_type.dart';

import '../models/enums.dart';
import '../types.dart';
import '../utils/functions.dart';
import 'calendar_page.dart';

class FlutterCalendarBase extends StatelessWidget {
  final DateTime focusedDate;
  final List<DateTime> selectedDates;
  final DateTime firstDate;
  final DateTime lastDate;
  final FlutterCalendarSelectionMode selectionMode;
  final DayOfWeek startingDayOfWeek;
  final PageController pageController;
  final OnPageChanged onPageChanged;
  final DayBuilder dayBuilder;
  final DateTimeBuilder dowBuilder;
  final ScrollPhysics? scrollPhysics;

  const FlutterCalendarBase({
    Key? key,
    required this.focusedDate,
    required this.selectedDates,
    required this.firstDate,
    required this.lastDate,
    required this.selectionMode,
    required this.startingDayOfWeek,
    required this.pageController,
    required this.onPageChanged,
    required this.dayBuilder,
    required this.dowBuilder,
    this.scrollPhysics,
  }) : super(key: key);

  DateTime _firstDateOfMonth(DateTime currentDateTime) =>
      DateTime(currentDateTime.year, currentDateTime.month, 1);

  int _getDaysBefore(DateTime firstDateOfMonth) =>
      (firstDateOfMonth.weekday + 7 - getWeekdayNumber(startingDayOfWeek)) % 7;

  DateTimeRange _daysInMonth(DateTime currentDateTime) {
    final firstDayOfMonth = _firstDateOfMonth(currentDateTime);
    final daysBefore = _getDaysBefore(firstDayOfMonth);
    final firstToDisplay = firstDayOfMonth.subtract(Duration(days: daysBefore));

    final lastDayOfMonth = _lastDayOfMonth(currentDateTime);
    final daysAfter = _getDaysAfter(lastDayOfMonth);
    final lastToDisplay = lastDayOfMonth.add(Duration(days: daysAfter));

    return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
  }

  DateTime _lastDayOfMonth(DateTime currentDateTim) {
    final DateTime date = currentDateTim.month < 12
        ? DateTime(currentDateTim.year, currentDateTim.month + 1, 1)
        : DateTime(currentDateTim.year + 1, 1, 1);

    return date.subtract(const Duration(days: 1));
  }

  int _getDaysAfter(DateTime lastDate) {
    int invertedStartingWeekday = 8 - getWeekdayNumber(startingDayOfWeek);
    int daysAfter = 7 - ((lastDate.weekday + invertedStartingWeekday) % 7);

    if (daysAfter == 7) {
      return 0;
    }

    return daysAfter;
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;

    return List.generate(
      dayCount,
      (index) => DateTime(first.year, first.month, first.day + index),
    );
  }

  bool _isSelectedDay(DateTime date) {
    return shouldFindSameDayFromList(selectedDates, date);
  }

  bool _isRange(DateTime date) {
    if (selectionMode == FlutterCalendarSelectionMode.range &&
        selectedDates.length > 1) {
      return (selectedDates.first.isBefore(date) &&
              selectedDates.last.isAfter(date)) ||
          (selectedDates.first.isAfter(date) &&
              selectedDates.last.isBefore(date));
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: scrollPhysics,
      onPageChanged: (int index) {
        final DateTime baseDay =
            DateTime(firstDate.year, firstDate.month + index);

        onPageChanged(index, baseDay);
      },
      itemCount: getMonthCount(firstDate, lastDate) + 1,
      itemBuilder: (BuildContext _, int index) {
        final DateTime baseDay =
            DateTime(firstDate.year, firstDate.month + index);

        final DateTimeRange visibleRange = _daysInMonth(baseDay);
        final List<DateTime> visibleDays =
            _daysInRange(visibleRange.start, visibleRange.end);

        return CalendarPage(
          visibleDays: visibleDays,
          dowBuilder: dowBuilder,
          dayBuilder: (DateTime dateTime) {
            DateTime baseDay =
                DateTime(firstDate.year, firstDate.month + index);

            bool isOutSide = dateTime.month != baseDay.month;

            return dayBuilder(
              dateTime,
              DateType(
                isFocused: isSameDay(
                  dateTime,
                  focusedDate,
                ),
                isRange: _isRange(dateTime),
                isSelected: _isSelectedDay(dateTime),
                isOutSide: isOutSide,
              ),
            );
          },
        );
      },
    );
  }
}
