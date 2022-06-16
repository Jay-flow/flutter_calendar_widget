import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class SingleDemoScreen extends StatelessWidget {
  const SingleDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single demo screen'),
      ),
      body: SafeArea(
        child: FlutterCalendar(
          selectionMode: FlutterCalendarSelectionMode.single,
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
