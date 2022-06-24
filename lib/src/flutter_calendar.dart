import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';
import 'package:flutter_calendar_widget/src/classes/default_calender_builder.dart';
import 'package:flutter_calendar_widget/src/types.dart';
import 'package:flutter_calendar_widget/src/utils/constants.dart';
import 'package:flutter_calendar_widget/src/utils/functions.dart';
import 'package:flutter_calendar_widget/src/widgets/empty.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_base.dart';
import 'package:flutter_calendar_widget/src/widgets/flutter_calendar_header.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// The [FlutterCalendar] is a flexible and freely changeable calendar of widgets.
class FlutterCalendar extends StatefulWidget {
  /// Date focused on the calendar.
  /// The calendar displays the first calendar based on that date.
  final DateTime? focusedDate;

  final List<DateTime>? selectedDates;

  /// Minimum date to be displayed in the calendar.
  final DateTime? minDate;

  /// Maximum date to be displayed in the calendar.
  final DateTime? maxDate;

  /// The mode of calendar to select.
  final CalendarSelectionMode selectionMode;

  /// The day of the week to start on the calendar.
  final DayOfWeek startingDayOfWeek;

  /// Instance that inherited [CalendarBuilder] to create a custom calendar.
  final CalendarBuilder? calendarBuilder;

  /// Called whenever any day gets tapped.
  final DateTimeCallback? onDayPressed;

  /// Called whenever any day gets long pressed
  final DateTimeCallback? onDayLongPressed;

  /// Callback when range date is selected.
  final OnRageDate? onRageDate;

  /// Callback when multiple dates are selected.
  final OnMultipleDates? onMultipleDates;
  final ScrollPhysics? scrollPhysics;

  /// The page controller for the calendar.
  final PageController? pageController;

  /// Callback when the page of the calendar changes.
  final OnPageChanged? onPageChanged;

  /// Events to be displayed in the calendar.
  final EventList? events;

  /// Specifies styles other than text styles in the calendar.
  final CalendarStyle style;

  /// Specifies the text style of the calendar.
  final CalendarTextStyle textStyle;

  /// Whether the calendar's navigation header will be visible.
  final bool isHeaderDisplayed;

  /// Locale to format `TableCalendar` dates with, for example: `'ko'`.
  ///
  /// If nothing is provided, a default locale will be used.
  final String? locale;

  const FlutterCalendar({
    Key? key,
    this.focusedDate,
    this.selectedDates,
    this.minDate,
    this.maxDate,
    this.selectionMode = CalendarSelectionMode.single,
    this.startingDayOfWeek = DayOfWeek.sun,
    this.events,
    this.calendarBuilder,
    this.onDayPressed,
    this.onDayLongPressed,
    this.onRageDate,
    this.onMultipleDates,
    this.scrollPhysics,
    this.pageController,
    this.onPageChanged,
    this.style = const CalendarStyle(),
    this.textStyle = const CalendarTextStyle(),
    this.isHeaderDisplayed = true,
    this.locale,
  }) : super(key: key);

  @override
  State<FlutterCalendar> createState() => _FlutterCalendarState();
}

class _FlutterCalendarState extends State<FlutterCalendar> {
  late DateTime _focusedDate;
  late List<DateTime> _selectedDates;
  late DateTime _currentPageMonth;
  late DateTime _minDate;
  late DateTime _maxDate;
  late PageController _pageController;
  late CalendarBuilder _calenderBuilder;
  late String _locale;

  @override
  void initState() {
    initializeDateFormatting();
    _init();
    super.initState();
  }

  @override
  void didUpdateWidget(FlutterCalendar oldWidget) {
    _calenderBuilder.textStyle = widget.textStyle;
    _calenderBuilder.style = widget.style;

    if (_focusedDate != widget.focusedDate) {
      _focusedDate = widget.focusedDate ?? today;
    }

    super.didUpdateWidget(oldWidget);
  }

  void _init() {
    _focusedDate = widget.focusedDate ?? today;
    _selectedDates = widget.selectedDates ?? [];
    _currentPageMonth = _focusedDate;
    _calenderBuilder = widget.calendarBuilder ?? DefaultCalenderBuilder();
    _calenderBuilder.textStyle = widget.textStyle;
    _calenderBuilder.style = widget.style;
    _minDate = widget.minDate ??
        DateTime(_focusedDate.year, _focusedDate.month - 3, _focusedDate.day);
    _maxDate = widget.maxDate ??
        DateTime(_focusedDate.year, _focusedDate.month + 3, _focusedDate.day);
    _pageController = widget.pageController ??
        PageController(
          initialPage: getMonthCount(_minDate, _focusedDate),
        );
    _locale = widget.locale ?? Platform.localeName;
  }

  void _updateSelectedDay(DateTime day) {
    setState(() {
      if (widget.selectionMode == CalendarSelectionMode.single) {
        _selectedDates = [day];
      } else if (widget.selectionMode == CalendarSelectionMode.range) {
        _updateRageDay(day);
      } else if (widget.selectionMode == CalendarSelectionMode.multiple) {
        _selectedDates.add(day);
      }
    });
  }

  void _updateRageDay(DateTime day) {
    if (_isTapSameDate(day) || _selectedDates.length == 2) {
      _selectedDates = [day];
    } else {
      _selectedDates.add(day);
      _selectedDates.sort((a, b) => a.compareTo(b));
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
    if (widget.onDayPressed != null) {
      widget.onDayPressed!(_selectedDates.first);
    }
    if (widget.onRageDate != null) {
      if (widget.selectionMode != CalendarSelectionMode.range) {
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
                calendarBuilder: _calenderBuilder,
                locale: _locale,
              )
            : const Empty(),
        Container(
          margin: widget.style.calenderMargin,
          padding: widget.style.calenderPadding,
          child: FlutterCalendarBase(
            focusedDate: _focusedDate,
            selectedDates: _selectedDates,
            minDate: _minDate,
            maxDate: _maxDate,
            selectionMode: widget.selectionMode,
            startingDayOfWeek: widget.startingDayOfWeek,
            pageController: _pageController,
            daysRowHeight: widget.style.daysRowHeight,
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
                _locale,
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
                    child: _calenderBuilder.buildDate(
                      dateTime,
                      type,
                      widget.events?.get(dateTime) ?? [],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
