import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class RangeDemoScreen extends StatelessWidget {
  const RangeDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single demo screen'),
      ),
      body: SafeArea(
        child: FlutterCalendar(
          selectionMode: FlutterCalendarSelectionMode.range,
          onRageDate: (CalendarDateRange dateRange) {
            logger.i(
              '[onRageDate] start: ${dateRange.start}, end ${dateRange.end}',
            );
          },
        ),
      ),
    );
  }
}
