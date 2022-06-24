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
  ///
  /// ![single_demo](https://raw.githubusercontent.com/dooboolab/flutter_calendar_widget/main/doc/single_demo.gif)
  single,

  /// [CalendarSelectionMode.multiple], Allows multiple date selection,
  /// selecting a new date will not remove the selection for previous dates,
  /// allows to select as many dates as possible.
  ///
  /// ![multiple_demo](https://raw.githubusercontent.com/dooboolab/flutter_calendar_widget/main/doc/multiple_demo.gif)
  multiple,

  /// [CalendarSelectionMode.range], Allows to select a single range of
  /// dates.
  ///
  /// ![range_demo](https://raw.githubusercontent.com/dooboolab/flutter_calendar_widget/main/doc/range_demo.gif)
  range,
}
