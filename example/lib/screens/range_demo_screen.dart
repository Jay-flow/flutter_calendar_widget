import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class RangeDemoScreen extends StatefulWidget {
  const RangeDemoScreen({Key? key}) : super(key: key);

  @override
  State<RangeDemoScreen> createState() => _SingleDemoScreenState();
}

class _SingleDemoScreenState extends State<RangeDemoScreen> {
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
          onDayPressed: (DateTime day) {
            logger.d('[onDayPressed] $day');
          },
          onDayLongPressed: (DateTime day) {
            logger.d('[onDayLongPressed] $day');
          },
        ),
      ),
    );
  }
}
