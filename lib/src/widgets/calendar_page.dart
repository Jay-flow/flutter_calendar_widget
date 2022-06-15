import 'package:flutter/material.dart';

import '../types.dart';

class CalendarPage extends StatelessWidget {
  final List<DateTime> visibleDays;
  final DateTimeBuilder dayBuilder;
  final DateTimeBuilder dowBuilder;
  final TableBorder? tableBorder;
  final Decoration? rowDecoration;
  final Decoration? dowDecoration;

  const CalendarPage({
    Key? key,
    required this.visibleDays,
    required this.dayBuilder,
    required this.dowBuilder,
    this.dowDecoration,
    this.tableBorder,
    this.rowDecoration,
  }) : super(key: key);

  TableRow _buildDaysOfWeek(BuildContext context) {
    return TableRow(
      decoration: dowDecoration,
      children: List.generate(
        7,
        (index) => dowBuilder(visibleDays[index]),
      ).toList(),
    );
  }

  List<TableRow> _buildCalendarDays(BuildContext context) {
    final rowAmount = visibleDays.length ~/ 7;

    return List.generate(rowAmount, (index) => index * 7)
        .map(
          (index) => TableRow(
            decoration: rowDecoration,
            children: List.generate(
              7,
              (id) => dayBuilder(visibleDays[index + id]),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: tableBorder,
      children: [
        _buildDaysOfWeek(context),
        ..._buildCalendarDays(context),
      ],
    );
  }
}
