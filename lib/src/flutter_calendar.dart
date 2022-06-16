import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';
import 'package:flutter_calendar_widget/src/models/date_type.dart';
import 'package:flutter_calendar_widget/src/types.dart';
import 'package:flutter_calendar_widget/src/utils/constants.dart';
import 'package:flutter_calendar_widget/src/utils/errors.dart';
import 'package:flutter_calendar_widget/src/utils/functions.dart';
import 'package:flutter_calendar_widget/src/widgets/empty.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_base.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_header.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FlutterCalendar extends StatefulWidget {
  final DateTime? focusedDate;
  final List<DateTime>? selectedDates;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FlutterCalendarSelectionMode selectionMode;
  final DayOfWeek startingDayOfWeek;
  final DateTimeCallback? onDayPressed;
  final DateTimeCallback? onDayLongPressed;
  final OnRageDate? onRageDate;
  final ScrollPhysics? scrollPhysics;
  final PageController? pageController;
  final OnPageChanged? onPageChanged;
  final DowBuilder? dowBuilder;
  final DayBuilder? dayBuilder;

  const FlutterCalendar({
    Key? key,
    this.focusedDate,
    this.selectedDates,
    this.firstDate,
    this.lastDate,
    this.selectionMode = FlutterCalendarSelectionMode.single,
    this.startingDayOfWeek = DayOfWeek.sun,
    required this.onDayPressed,
    this.onDayLongPressed,
    this.onRageDate,
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
  late DateTime _focusedDate;
  late List<DateTime> _selectedDates;
  late DateTime _currentPageMonth;
  late final DateTime _firstDate;
  late final DateTime _lastDate;
  late final PageController _pageController;

  @override
  void initState() {
    initializeDateFormatting();

    _focusedDate = widget.focusedDate ?? today;
    _selectedDates = widget.selectedDates ?? [];
    _currentPageMonth = _focusedDate;
    _firstDate = widget.firstDate ??
        DateTime(_focusedDate.year, _focusedDate.month - 3, _focusedDate.day);
    _lastDate = widget.lastDate ??
        DateTime(_focusedDate.year, _focusedDate.month + 3, _focusedDate.day);
    _pageController = widget.pageController ??
        PageController(
          initialPage: getMonthCount(_firstDate, _focusedDate),
        );

    super.initState();
  }

  void _updateSelectedDay(DateTime day) {
    setState(() {
      if (widget.selectionMode == FlutterCalendarSelectionMode.single) {
        _selectedDates = [day];
      } else if (widget.selectionMode == FlutterCalendarSelectionMode.range) {
        _updateRageDay(day);
      }
    });
  }

  void _updateRageDay(DateTime day) {
    if (_isTapSameDate(day) || _selectedDates.length == 2) {
      _selectedDates = [day];
    } else {
      _selectedDates.add(day);
    }
  }

  bool _isTapSameDate(date) =>
      _selectedDates.isNotEmpty &&
      shouldFindSameDayFromList(_selectedDates, date);

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

  void _returnDays() {
    if (_selectedDates.length > 1) {
      _selectedDates.sort((a, b) => a.compareTo(b));
    }
    if (widget.onDayPressed != null) {
      widget.onDayPressed!(_selectedDates.first);
    }
    if (widget.onRageDate != null) {
      if (widget.selectionMode != FlutterCalendarSelectionMode.range) {
        throw ValueException(onRageDateUsageErrorMessage);
      }

      widget.onRageDate!(_getCalendarDateRange());
    }
  }

  CalendarDateRange _getCalendarDateRange() {
    CalendarDateRange dateRange = CalendarDateRange(start: null, end: null);

    if (_selectedDates.length == 1) {
      dateRange.start = _selectedDates[0];
    } else {
      dateRange.start = _selectedDates[0];
      dateRange.end = _selectedDates[1];
    }

    return dateRange;
  }

  Widget _buildDate(DateType type) {
    if (type.isSelected) {
      return Container(
        color: Colors.black,
      );
    }
    if (type.isRange) {
      return Container(
        color: Colors.grey[300],
      );
    }
    if (type.isFocused) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black),
        ),
      );
    }

    return const Empty();
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
            focusedDate: _focusedDate,
            selectedDates: _selectedDates,
            firstDate: _firstDate,
            lastDate: _lastDate,
            selectionMode: widget.selectionMode,
            startingDayOfWeek: widget.startingDayOfWeek,
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
                onTap: () => _returnDays(),
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
                            _buildDate(type),
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
