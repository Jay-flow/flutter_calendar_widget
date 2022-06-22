import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/enums.dart';
import 'package:collection/collection.dart';

int getWeekdayNumber(DayOfWeek weekday) =>
    DayOfWeek.values.indexOf(weekday) + 1;

int getMonthCount(DateTime firstDay, DateTime lastDay) {
  final int yearDif = lastDay.year - firstDay.year;
  final int monthDif = lastDay.month - firstDay.month;

  return (yearDif * 12 + monthDif).abs();
}

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool isDarkMode() {
  Brightness brightness = SchedulerBinding.instance.window.platformBrightness;

  return brightness == Brightness.dark;
}

bool shouldFindSameDayFromList(
  List<DateTime> dateTimeList,
  DateTime dateTimeToFind,
) {
  DateTime? foundDateTime = dateTimeList.firstWhereOrNull(
    (element) => isSameDay(element, dateTimeToFind),
  );

  if (foundDateTime == null) {
    return false;
  }

  return true;
}

int findIndexFromList(List<DateTime> dateTimeList, DateTime dateTimeToFind) =>
    dateTimeList.indexWhere((element) => isSameDay(element, dateTimeToFind));
