import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/classes/calender_builder.dart';

class FlutterCalendarHeader extends StatelessWidget {
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final DateTime currentPageMonth;
  final CalenderBuilder calenderBuilder;

  const FlutterCalendarHeader({
    Key? key,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.currentPageMonth,
    required this.calenderBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return calenderBuilder.buildHeader(
      onLeftChevronTap,
      onRightChevronTap,
      currentPageMonth,
    );
  }
}
