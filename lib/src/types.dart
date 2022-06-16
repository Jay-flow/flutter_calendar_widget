import 'package:flutter/widgets.dart';

import 'models/date_type.dart';

typedef FocusedDayBuilder = Widget? Function(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
);

typedef DateTimeBuilder = Widget Function(DateTime dateTime);
typedef DateTimeCallback = void Function(DateTime dateTime);
typedef OnPageChanged = void Function(int index, DateTime dateTime);
typedef DayBuilder = Widget Function(DateTime dateTime, DateType type);
typedef DowBuilder = Widget Function(DateTime dateTime, String weekDay);
