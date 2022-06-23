import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/classes/calendar_builder.dart';

class FlutterCalendarHeader extends StatelessWidget {
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final DateTime currentPageMonth;
  final CalendarBuilder calendarBuilder;
  final String locale;

  const FlutterCalendarHeader({
    Key? key,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.currentPageMonth,
    required this.calendarBuilder,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return calendarBuilder.buildHeader(
      onLeftChevronTap,
      onRightChevronTap,
      currentPageMonth,
      locale,
    );
  }
}
