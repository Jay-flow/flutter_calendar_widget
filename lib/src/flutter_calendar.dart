import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';
import 'package:flutter_calendar_widget/src/classes/default_calender_builder.dart';
import 'package:flutter_calendar_widget/src/models/calender_style.dart';
import 'package:flutter_calendar_widget/src/models/calender_text_style.dart';
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
  final DateTime? minDate;
  final DateTime? maxDate;
  final FlutterCalendarSelectionMode selectionMode;
  final DayOfWeek startingDayOfWeek;
  final CalenderBuilder? calenderBuilder;
  final DateTimeCallback? onDayPressed;
  final DateTimeCallback? onDayLongPressed;
  final OnRageDate? onRageDate;
  final OnMultipleDates? onMultipleDates;
  final ScrollPhysics? scrollPhysics;
  final PageController? pageController;
  final OnPageChanged? onPageChanged;
  final double daysOfWeekHeight;
  final double daysRowHeight;
  final EventList? events;
  final CalenderStyle style;
  final CalenderTextStyle textStyle;
  final bool isHeaderDisplayed;

  const FlutterCalendar({
    Key? key,
    this.focusedDate,
    this.selectedDates,
    this.minDate,
    this.maxDate,
    this.selectionMode = FlutterCalendarSelectionMode.single,
    this.startingDayOfWeek = DayOfWeek.sun,
    this.events,
    this.calenderBuilder,
    this.onDayPressed,
    this.onDayLongPressed,
    this.onRageDate,
    this.onMultipleDates,
    this.scrollPhysics,
    this.pageController,
    this.onPageChanged,
    this.daysOfWeekHeight = 30,
    this.daysRowHeight = 52,
    this.style = const CalenderStyle(),
    this.textStyle = const CalenderTextStyle(),
    this.isHeaderDisplayed = true,
  }) : super(key: key);

  @override
  State<FlutterCalendar> createState() => _FlutterCalendarState();
}

class _FlutterCalendarState extends State<FlutterCalendar> {
  late DateTime _focusedDate;
  late List<DateTime> _selectedDates;
  late DateTime _currentPageMonth;
  late final DateTime _minDate;
  late final DateTime _maxDate;
  late final PageController _pageController;
  late final CalenderBuilder _calenderBuilder;

  @override
  void initState() {
    initializeDateFormatting();

    _focusedDate = widget.focusedDate ?? today;
    _selectedDates = widget.selectedDates ?? [];
    _currentPageMonth = _focusedDate;
    _calenderBuilder = widget.calenderBuilder ??
        DefaultCalenderBuilder(
          textStyle: widget.textStyle,
          style: widget.style,
        );
    _minDate = widget.minDate ??
        DateTime(_focusedDate.year, _focusedDate.month - 3, _focusedDate.day);
    _maxDate = widget.maxDate ??
        DateTime(_focusedDate.year, _focusedDate.month + 3, _focusedDate.day);
    _pageController = widget.pageController ??
        PageController(
          initialPage: getMonthCount(_minDate, _focusedDate),
        );

    super.initState();
  }

  void _updateSelectedDay(DateTime day) {
    setState(() {
      if (widget.selectionMode == FlutterCalendarSelectionMode.single) {
        _selectedDates = [day];
      } else if (widget.selectionMode == FlutterCalendarSelectionMode.range) {
        _updateRageDay(day);
      } else if (widget.selectionMode ==
          FlutterCalendarSelectionMode.multiple) {
        _selectedDates.add(day);
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
    if (widget.onMultipleDates != null) {
      widget.onMultipleDates!(_selectedDates);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isHeaderDisplayed
            ? FlutterCalendarHeader(
                currentPageMonth: _currentPageMonth,
                onLeftChevronTap: _onLeftChevronTap,
                onRightChevronTap: _onRightChevronTap,
                calenderBuilder: _calenderBuilder,
              )
            : const Empty(),
        FlutterCalendarBase(
          focusedDate: _focusedDate,
          selectedDates: _selectedDates,
          minDate: _minDate,
          maxDate: _maxDate,
          selectionMode: widget.selectionMode,
          startingDayOfWeek: widget.startingDayOfWeek,
          pageController: _pageController,
          daysOfWeekHeight: widget.daysOfWeekHeight,
          daysRowHeight: widget.daysRowHeight,
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

            return _calenderBuilder.buildDayOfWeek(dateTime, weekdayString);
          },
          dayBuilder: (DateTime dateTime, DateType type) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (_) => _updateSelectedDay(dateTime),
                  onTap: () => _returnDays(),
                  onLongPress: () {
                    if (widget.onDayLongPressed != null) {
                      widget.onDayLongPressed!(dateTime);
                    }
                  },
                  child: _calenderBuilder.build(
                    dateTime,
                    type,
                    widget.events?.get(dateTime) ?? [],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
