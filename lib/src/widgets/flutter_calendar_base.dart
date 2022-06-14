import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';
import '../utils/date.dart';
import 'calendar_page.dart';

class FlutterCalendarBase extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final DayOfWeek startingDayOfWeek;
  final PageController pageController;
  final ScrollPhysics? scrollPhysics;

  const FlutterCalendarBase({
    Key? key,
    this.selectedDay,
    required this.firstDay,
    required this.lastDay,
    required this.startingDayOfWeek,
    required this.pageController,
    this.scrollPhysics,
  }) : super(key: key);

  final DayOfWeek _startingDayOfWeek = DayOfWeek.sun;

  DateTime _firstDayOfMonth(DateTime currentDateTime) =>
      DateTime(currentDateTime.year, currentDateTime.month, 1);

  int _getDaysBefore(DateTime firstDayOfMonth) =>
      (firstDayOfMonth.weekday + 7 - getWeekdayNumber(_startingDayOfWeek)) % 7;

  DateTimeRange _daysInMonth(DateTime currentDateTime) {
    final firstDayOfMonth = _firstDayOfMonth(currentDateTime);
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

  int _getDaysAfter(DateTime lastDay) {
    int invertedStartingWeekday = 8 - getWeekdayNumber(_startingDayOfWeek);
    int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7);

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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageController,
        itemCount: getMonthCount(firstDay, lastDay) + 1,
        itemBuilder: (BuildContext _, int index) {
          final DateTime baseDay =
              DateTime(firstDay.year, firstDay.month + index);

          final DateTimeRange visibleRange = _daysInMonth(baseDay);
          final List<DateTime> visibleDays =
              _daysInRange(visibleRange.start, visibleRange.end);

          return CalendarPage(
            dowBuilder: (BuildContext _, DateTime dateTime) {
              final String weekdayString = DateFormat.E(
                Localizations.localeOf(context).languageCode,
              ).format(dateTime);

              return Center(child: Text(weekdayString));
            },
            dayBuilder: (BuildContext context, DateTime dateTime) {
              DateTime baseDay =
                  DateTime(firstDay.year, firstDay.month + index);

              bool isOutSide = dateTime.month != baseDay.month;

              return GestureDetector(
                onTap: () => debugPrint('onTap'),
                child: Container(
                  margin: const EdgeInsetsDirectional.all(10),
                  child: Center(
                    child: Text(
                      dateTime.day.toString(),
                      style: TextStyle(
                        // TODO:: Apply dark theme color
                        color: isOutSide ? outSideDayColor : dayColor,
                      ),
                    ),
                  ),
                ),
              );
            },
            visibleDays: visibleDays,
          );
        });
  }
}
