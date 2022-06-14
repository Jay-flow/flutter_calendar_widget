import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/utils/constants.dart';
import 'package:flutter_calendar_widget/src/utils/date.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_base.dart';

class FlutterCalendar extends StatefulWidget {
  final DateTime? selectedDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final ScrollPhysics? scrollPhysics;
  final PageController? pageController;

  const FlutterCalendar({
    Key? key,
    this.selectedDay,
    this.firstDay,
    this.lastDay,
    this.scrollPhysics,
    this.pageController,
  }) : super(key: key);

  @override
  State<FlutterCalendar> createState() => _FlutterCalendarState();
}

class _FlutterCalendarState extends State<FlutterCalendar> {
  late final DateTime _selectedDay;
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late final PageController _pageController;

  final DayOfWeek _startingDayOfWeek = DayOfWeek.sun;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay ?? today;
    _firstDay = widget.firstDay ?? firstDay;
    _lastDay = widget.lastDay ?? lastDay;

    _pageController = PageController(
      initialPage: getMonthCount(firstDay, _selectedDay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterCalendarBase(
      firstDay: _firstDay,
      lastDay: _lastDay,
      startingDayOfWeek: _startingDayOfWeek,
      pageController: _pageController,
    );
  }
}
