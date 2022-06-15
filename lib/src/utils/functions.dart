import '../models/enums.dart';

int getWeekdayNumber(DayOfWeek weekday) =>
    DayOfWeek.values.indexOf(weekday) + 1;

int getMonthCount(DateTime firstDay, DateTime lastDay) {
  final int yearDif = lastDay.year - firstDay.year;
  final int monthDif = lastDay.month - firstDay.month;

  return (yearDif * 12 + monthDif);
}

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
