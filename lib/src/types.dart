import 'package:flutter/widgets.dart';

typedef FocusedDayBuilder = Widget? Function(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
);

typedef DayBuilder = Widget Function(BuildContext context, DateTime day);
