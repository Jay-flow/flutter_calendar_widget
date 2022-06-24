import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../flutter_calendar_widget.dart';
import '../widgets/empty.dart';

/// An abstract class for building a date widget on the calendar.
///
/// If you want to customize the date widget,
/// inherit the class and implement it.
///
/// See also:
/// [Demo](https://github.com/dooboolab/flutter_calendar_widget/blob/main/example/lib/screens/custom_demo_screen.dart)
abstract class CalendarBuilder {
  late CalendarStyle style;
  late CalendarTextStyle textStyle;

  /// Method for building the navigation header of the calendar.
  Widget buildHeader(
    VoidCallback onLeftTap,
    VoidCallback onRightTap,
    DateTime dateTime,
    String locale,
  ) {
    final month = DateFormat.yMMMM(locale).format(dateTime);

    return Container(
      margin: style.headerMargin,
      padding: style.headerPadding,
      child: Row(
        children: [
          IconButton(
            onPressed: onLeftTap,
            icon: style.headerLeftIcon,
          ),
          Expanded(
            child: Text(
              month,
              style: textStyle.headerTextStyle,
            ),
          ),
          IconButton(
            onPressed: onRightTap,
            icon: style.headerRightIcon,
          ),
        ],
      ),
    );
  }

  /// Build the date of the calendar. Widgets are placed in the Stack.
  /// It's made up of three main types.
  ///
  /// 1. Lines marked when selecting a calendar range
  /// 2. Date text for the calendar
  /// 3. Event Display Marker
  Widget buildDate(
    DateTime dateTime,
    DateType type,
    List events,
  ) {
    return Padding(
      padding: style.daysRowPadding,
      child: Stack(
        alignment: style.dayAlignment,
        children: [
          type.isWithinRange
              ? LayoutBuilder(builder: (context, constraints) {
                  return buildRangeLine(type, constraints);
                })
              : const Empty(),
          buildDay(dateTime, type),
          events.isNotEmpty ? buildEvents(events) : const Empty(),
        ],
      ),
    );
  }

  Widget buildRangeLine(DateType type, BoxConstraints constraints) {
    if (type.isRangeStart) {
      return buildRangeStartLine(constraints);
    }
    if (type.isRangeEnd) {
      return buildRangeEndLine(constraints);
    }
    if (type.isRange) {
      return buildRangeDayLine(constraints);
    }

    return const Empty();
  }

  Widget buildRangeStartLine(BoxConstraints constraints) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: constraints.maxWidth / 2,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0,
            color: style.rangeLineColor,
          ),
          color: style.rangeLineColor,
        ),
      ),
    );
  }

  Widget buildRangeEndLine(BoxConstraints constraints) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: constraints.maxWidth / 2,
        decoration: BoxDecoration(
          border: Border.all(width: 0, color: style.rangeLineColor),
          color: style.rangeLineColor,
        ),
      ),
    );
  }

  Widget buildRangeDayLine(BoxConstraints constraints) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: style.rangeLineColor),
        color: style.rangeLineColor,
      ),
    );
  }

  Widget buildDay(DateTime dateTime, DateType type) {
    if (type.isSelected) {
      return buildSelectedDay(dateTime);
    }
    if (type.isRange) {
      return buildRangeDay(dateTime);
    }
    if (type.isRangeStart) {
      return buildRangeStartDay(dateTime);
    }
    if (type.isRangeEnd) {
      return buildRangeEndDay(dateTime);
    }
    if (type.isFocused) {
      return buildFocusedDay(dateTime);
    }
    if (type.isOutSide) {
      return buildOutSideDay(dateTime);
    }

    return buildDefaultDay(dateTime);
  }

  Widget buildEvents(List events) {
    return Align(
      alignment: style.eventAlignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: (style.eventCounts < 0
                ? events.map((e) => buildEvent(e))
                : events.take(style.eventCounts).map((e) => buildEvent(e)))
            .toList(),
      ),
    );
  }

  Container buildEvent(dynamic event) {
    return Container(
      height: style.eventSize,
      width: style.eventSize,
      margin: style.eventMargin,
      decoration: BoxDecoration(
        color: style.eventColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildDayOfWeek(DateTime dateTime, String weekdayString) {
    return Container(
      margin: style.dayOfWeekMargin,
      padding: style.dayOfWeekPadding,
      child: Align(
        alignment: style.dayOfWeekAlignment,
        child: Text(
          weekdayString,
          style: TextStyle(
            color: textStyle.dayOfWeekTextColor,
            fontSize: textStyle.dayOfWeekFontSize,
          ),
        ),
      ),
    );
  }

  Widget buildSelectedDay(DateTime dateTime) {
    return Stack(
      alignment: style.dayAlignment,
      children: [
        buildMarker(
          color: style.markerColor,
        ),
        buildDayText(
          dateTime,
          textStyle.selectedDayTextColor,
        ),
      ],
    );
  }

  Widget buildRangeDay(DateTime dateTime) {
    return Align(
      alignment: style.dayAlignment,
      child: Text(
        dateTime.day.toString(),
        style: TextStyle(
          color: textStyle.rangeDayTextColor,
        ),
      ),
    );
  }

  Widget buildRangeStartDay(DateTime dateTime) {
    return Stack(
      alignment: style.dayAlignment,
      children: [
        buildMarker(
          color: style.markerColor,
        ),
        buildDayText(
          dateTime,
          textStyle.rangeDayTextColor,
        ),
      ],
    );
  }

  Widget buildRangeEndDay(DateTime dateTime) {
    return Stack(
      alignment: style.dayAlignment,
      children: [
        buildMarker(
          color: style.markerColor,
        ),
        buildDayText(
          dateTime,
          textStyle.rangeDayTextColor,
        ),
      ],
    );
  }

  Widget buildFocusedDay(DateTime dateTime) {
    return Stack(
      alignment: style.dayAlignment,
      children: [
        buildMarker(
          borderWidth: style.focusedDayBorderWidth,
        ),
        buildDayText(
          dateTime,
          textStyle.focusedDayTextColor,
        ),
      ],
    );
  }

  Widget buildOutSideDay(DateTime dateTime) {
    return Align(
      alignment: style.dayAlignment,
      child: buildDayText(
        dateTime,
        textStyle.outsideDayTextColor,
      ),
    );
  }

  Widget buildDefaultDay(DateTime dateTime) {
    return Align(
      alignment: style.dayAlignment,
      child: buildDayText(
        dateTime,
        textStyle.dayTextColor,
      ),
    );
  }

  Widget buildMarker({Color? color, double borderWidth = 1}) {
    return Container(
      width: style.markerSize,
      height: style.markerSize,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
          color: style.markerColor,
        ),
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildDayText(DateTime dateTime, Color textColor) {
    return Text(
      dateTime.day.toString(),
      style: TextStyle(
        color: textColor,
        fontSize: textStyle.dayFontSize,
      ),
    );
  }
}
