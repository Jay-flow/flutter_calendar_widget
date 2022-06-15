import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/utils/functions.dart';
import 'package:intl/intl.dart';

class FlutterCalendarHeader extends StatelessWidget {
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final DateTime currentPageMonth;

  const FlutterCalendarHeader({
    Key? key,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.currentPageMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final month =
        DateFormat.yMMMM(getLanguageCode(context)).format(currentPageMonth);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: onLeftChevronTap,
            icon: const Icon(
              Icons.chevron_left_outlined,
            ),
          ),
          Expanded(
            child: Text(
              month,
              style: const TextStyle(fontSize: 17.0),
            ),
          ),
          IconButton(
            onPressed: onRightChevronTap,
            icon: const Icon(
              Icons.chevron_right_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
