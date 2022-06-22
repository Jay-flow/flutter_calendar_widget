import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

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

/// Selection modes for [FlutterCalendar].
enum CalendarSelectionMode {
  /// [CalendarSelectionMode.single], Allows to select a single date,
  /// selecting a new date will remove the selection for previous date and
  /// updates selection to the new selected date.
  single,

  /// [CalendarSelectionMode.multiple], Allows multiple date selection,
  /// selecting a new date will not remove the selection for previous dates,
  /// allows to select as many dates as possible.
  multiple,

  /// [CalendarSelectionMode.range], Allows to select a single range of
  /// dates.
  range,
}
