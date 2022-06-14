/// Days of the week that the calendar.
enum DayOfWeek {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun,
}

/// Returns a numerical value associated with given `weekday`.
///
/// Returns 1 for `StartingDayOfWeek.monday`, all the way to 7 for `StartingDayOfWeek.sunday`.
int getWeekdayNumber(DayOfWeek weekday) =>
    DayOfWeek.values.indexOf(weekday) + 1;

int getMonthCount(DateTime firstDay, DateTime lastDay) {
  final int yearDif = lastDay.year - firstDay.year;
  final int monthDif = lastDay.month - firstDay.month;

  return (yearDif * 12 + monthDif);
}
