import 'package:flutter/widgets.dart';

class FlutterCalendar extends StatefulWidget {
  const FlutterCalendar({
    Key? key,
    this.selectedDay,
  }) : super(key: key);

  final DateTime? selectedDay;

  @override
  State<FlutterCalendar> createState() => _FlutterCalendarState();
}

class _FlutterCalendarState extends State<FlutterCalendar> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Hello world');
  }
}
