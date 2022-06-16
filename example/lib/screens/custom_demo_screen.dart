import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class CustomCalenderBuilder extends CalenderBuilder {
  @override
  Widget buildSelectedDay(DateTime dateTime, DateType type) {
    return SizedBox(
      width: defaultWidth,
      height: defaultHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.green,
          ),
          Text(
            dateTime.day.toString(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildRangeDay(DateTime dateTime, DateType type) {
    return SizedBox(
      width: defaultWidth,
      height: defaultHeight,
      child: Container(
        alignment: Alignment.center,
        color: Colors.greenAccent,
        child: const Text(
          '😀',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class CustomDemoScreen extends StatelessWidget {
  const CustomDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom demo screen'),
      ),
      body: SafeArea(
        child: FlutterCalendar(
          selectionMode: FlutterCalendarSelectionMode.range,
          calenderBuilder: CustomCalenderBuilder(),
        ),
      ),
    );
  }
}
