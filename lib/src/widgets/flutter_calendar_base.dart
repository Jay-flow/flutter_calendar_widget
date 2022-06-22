import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/models/date_type.dart';
import 'package:flutter_calendar_widget/src/widgets/expandable_page_view.dart';
import 'package:flutter_calendar_widget/src/widgets/size_reporting_widget.dart';

import '../models/enums.dart';
import '../types.dart';
import '../utils/functions.dart';
import 'calendar_page.dart';

class FlutterCalendarBase extends StatefulWidget {
  final DateTime focusedDate;
  final List<DateTime> selectedDates;
  final DateTime minDate;
  final DateTime maxDate;
  final CalendarSelectionMode selectionMode;
  final DayOfWeek startingDayOfWeek;
  final PageController pageController;
  final OnPageChanged onPageChanged;
  final DayBuilder dayBuilder;
  final DateTimeBuilder dowBuilder;
  final ScrollPhysics? scrollPhysics;
  final double daysRowHeight;

  const FlutterCalendarBase({
    Key? key,
    required this.focusedDate,
    required this.selectedDates,
    required this.minDate,
    required this.maxDate,
    required this.selectionMode,
    required this.startingDayOfWeek,
    required this.pageController,
    required this.onPageChanged,
    required this.dayBuilder,
    required this.dowBuilder,
    required this.daysRowHeight,
    this.scrollPhysics,
  }) : super(key: key);

  @override
  State<FlutterCalendarBase> createState() => _FlutterCalendarBaseState();
}

class _FlutterCalendarBaseState extends State<FlutterCalendarBase> {
  late final List<double> _pageHeights = _preparePageHeights();

  List<double> _preparePageHeights() => List.filled(_getItemCount(), 0);

  void _updatePageHeight(int index, double height) =>
      setState(() => _pageHeights[index] = height);

  DateTime _firstDateOfMonth(DateTime currentDateTime) =>
      DateTime(currentDateTime.year, currentDateTime.month, 1);

  int _getDaysBefore(DateTime firstDateOfMonth) =>
      (firstDateOfMonth.weekday +
          7 -
          getWeekdayNumber(widget.startingDayOfWeek)) %
      7;

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

  int _getDaysAfter(DateTime maxDate) {
    int invertedStartingWeekday =
        8 - getWeekdayNumber(widget.startingDayOfWeek);
    int daysAfter = 7 - ((maxDate.weekday + invertedStartingWeekday) % 7);

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

  bool _isRangeSelectionMode() =>
      widget.selectionMode == CalendarSelectionMode.range;

  bool _isSelectedDay(DateTime date) {
    if (_isRangeSelectionMode()) {
      return false;
    }

    return shouldFindSameDayFromList(widget.selectedDates, date);
  }

  bool _isRangeStart(DateTime date) {
    if (!_isRangeSelectionMode()) {
      return false;
    }

    return findIndexFromList(widget.selectedDates, date) == 0;
  }

  bool _isRangeEnd(DateTime date) {
    if (!_isRangeSelectionMode()) {
      return false;
    }

    return findIndexFromList(widget.selectedDates, date) == 1;
  }

  bool _isRange(DateTime date) {
    if (_isRangeSelectionMode() && widget.selectedDates.length > 1) {
      return (widget.selectedDates.first.isBefore(date) &&
              widget.selectedDates.last.isAfter(date)) ||
          (widget.selectedDates.first.isAfter(date) &&
              widget.selectedDates.last.isBefore(date));
    }

    return false;
  }

  bool _isWithinRange(DateTime date) {
    if (!_isRangeSelectionMode() || widget.selectedDates.length < 2) {
      return false;
    }

    return _isRangeStart(date) || _isRangeEnd(date) || _isRange(date);
  }

  int _getItemCount() => getMonthCount(widget.minDate, widget.maxDate) + 1;

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      pageController: widget.pageController,
      pageHeights: _pageHeights,
      child: PageView.builder(
        controller: widget.pageController,
        physics: widget.scrollPhysics,
        onPageChanged: (int index) {
          final DateTime baseDay =
              DateTime(widget.minDate.year, widget.minDate.month + index);

          widget.onPageChanged(index, baseDay);
        },
        itemCount: _getItemCount(),
        itemBuilder: (BuildContext _, int index) {
          final DateTime baseDay =
              DateTime(widget.minDate.year, widget.minDate.month + index);

          final DateTimeRange visibleRange = _daysInMonth(baseDay);
          final List<DateTime> visibleDays =
              _daysInRange(visibleRange.start, visibleRange.end);

          return OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            child: SizeReportingWidget(
              onSizeChange: (size) => _updatePageHeight(index, size.height),
              child: CalendarPage(
                visibleDays: visibleDays,
                dowBuilder: (DateTime dateTime) {
                  return widget.dowBuilder(dateTime);
                },
                dayBuilder: (DateTime dateTime) {
                  DateTime baseDay = DateTime(
                      widget.minDate.year, widget.minDate.month + index);

                  bool isOutSide = dateTime.month != baseDay.month;

                  return SizedBox(
                    height: widget.daysRowHeight,
                    child: widget.dayBuilder(
                      dateTime,
                      DateType(
                        isFocused: isSameDay(
                          dateTime,
                          widget.focusedDate,
                        ),
                        isRange: _isRange(dateTime),
                        isRangeStart: _isRangeStart(dateTime),
                        isRangeEnd: _isRangeEnd(dateTime),
                        isSelected: _isSelectedDay(dateTime),
                        isWithinRange: _isWithinRange(dateTime),
                        isOutSide: isOutSide,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
