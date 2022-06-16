import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/src/models/date_type.dart';
import 'package:flutter_calendar_widget/src/types.dart';
import 'package:flutter_calendar_widget/src/utils/constants.dart';
import 'package:flutter_calendar_widget/src/utils/functions.dart';
import 'package:flutter_calendar_widget/src/widgets/empty.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_base.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_header.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'models/enums.dart';

class FlutterCalendar extends StatefulWidget {
  final DateTime? selectedDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTimeCallback onDayPressed;
  final DateTimeCallback? onDayLongPressed;
  final ScrollPhysics? scrollPhysics;
  final PageController? pageController;
  final OnPageChanged? onPageChanged;
  final DowBuilder? dowBuilder;
  final DayBuilder? dayBuilder;

  const FlutterCalendar({
    Key? key,
    this.selectedDay,
    this.firstDay,
    this.lastDay,
    required this.onDayPressed,
    this.onDayLongPressed,
    this.scrollPhysics,
    this.pageController,
    this.onPageChanged,
    this.dowBuilder,
    this.dayBuilder,
  }) : super(key: key);

  @override
  State<FlutterCalendar> createState() => _FlutterCalendarState();
}

class _FlutterCalendarState extends State<FlutterCalendar> {
  late DateTime _selectedDay;
  late DateTime _currentPageMonth;
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late final PageController _pageController;

  final DayOfWeek _startingDayOfWeek = DayOfWeek.sun;

  @override
  void initState() {
    initializeDateFormatting();

    _selectedDay = widget.selectedDay ?? today;
    _currentPageMonth = _selectedDay;
    _firstDay = widget.firstDay ?? firstDay;
    _lastDay = widget.lastDay ?? lastDay;

    _pageController = widget.pageController ??
        PageController(
          initialPage: getMonthCount(firstDay, _selectedDay),
        );

    super.initState();
  }

  void _updateSelectedDay(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
  }

  Color _getDayTextColor(DateType type) {
    // TODO:: Apply dark theme color
    if (type.isSelected) {
      return Colors.white;
    }
    if (type.isOutSide) {
      return Colors.grey;
    }

    return Colors.black;
  }

  void _onLeftChevronTap() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _onRightChevronTap() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterCalendarHeader(
          currentPageMonth: _currentPageMonth,
          onLeftChevronTap: _onLeftChevronTap,
          onRightChevronTap: _onRightChevronTap,
        ),
        Flexible(
          child: FlutterCalendarBase(
            selectedDay: _selectedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            startingDayOfWeek: _startingDayOfWeek,
            pageController: _pageController,
            onPageChanged: (int index, DateTime currentDateTime) {
              setState(() {
                _currentPageMonth = currentDateTime;
              });

              if (widget.onPageChanged != null) {
                widget.onPageChanged!(index, currentDateTime);
              }
            },
            dowBuilder: (DateTime dateTime) {
              final String weekdayString = DateFormat.E(
                Platform.localeName,
              ).format(dateTime);

              if (widget.dowBuilder != null) {
                return widget.dowBuilder!(dateTime, weekdayString);
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(child: Text(weekdayString)),
              );
            },
            dayBuilder: (DateTime dateTime, DateType type) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (_) => _updateSelectedDay(dateTime),
                onTap: () {
                  widget.onDayPressed(dateTime);
                },
                onLongPress: () {
                  if (widget.onDayLongPressed != null) {
                    widget.onDayLongPressed!(dateTime);
                  }
                },
                child: widget.dayBuilder != null
                    ? widget.dayBuilder!(dateTime, type)
                    : SizedBox(
                        width: 30,
                        height: 50,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            type.isSelected
                                ? Container(
                                    color: Colors.black,
                                  )
                                : const Empty(),
                            Text(
                              dateTime.day.toString(),
                              style: TextStyle(
                                color: _getDayTextColor(type),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
