import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/classes/calender_builder.dart';

class FlutterCalendarHeader extends StatelessWidget {
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final DateTime currentPageMonth;
  final CalenderBuilder calenderBuilder;
  final String locale;

  const FlutterCalendarHeader({
    Key? key,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.currentPageMonth,
    required this.calenderBuilder,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return calenderBuilder.buildHeader(
      onLeftChevronTap,
      onRightChevronTap,
      currentPageMonth,
      locale,
    );
  }
}
