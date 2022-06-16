import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class MultipleDemoScreen extends StatefulWidget {
  const MultipleDemoScreen({Key? key}) : super(key: key);

  @override
  State<MultipleDemoScreen> createState() => _MultipleDemoScreenState();
}

class _MultipleDemoScreenState extends State<MultipleDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple demo screen'),
      ),
      body: SafeArea(
        child: FlutterCalendar(
          selectionMode: FlutterCalendarSelectionMode.multiple,
          onMultipleDates: (List<DateTime> dates) {
            for (var date in dates) {
              logger.i('[onMultipleDates] $date');
            }
          },
        ),
      ),
    );
  }
}
