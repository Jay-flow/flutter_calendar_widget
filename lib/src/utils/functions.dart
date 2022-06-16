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
