import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

typedef FocusedDayBuilder = Widget? Function(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
);

typedef DateTimeBuilder = Widget Function(DateTime dateTime);
typedef DateTimeCallback = void Function(DateTime dateTime);
typedef OnPageChanged = void Function(int index, DateTime dateTime);
typedef OnRageDate = void Function(CalendarDateRange dateTimeRange);
typedef OnMultipleDates = void Function(List<DateTime> dates);
typedef DayBuilder = Widget Function(DateTime dateTime, DateType type);
typedef DowBuilder = Widget Function(DateTime dateTime, String weekDay);
