import 'package:flutter_calendar_widget/src/models/enums.dart';
import 'package:flutter_calendar_widget/src/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('The getWeekdayNumber function', () {
    test('Monday returns number 1', () {
      expect(getWeekdayNumber(DayOfWeek.mon), 1);
    });
    test('Tuesday returns number 2', () {
      expect(getWeekdayNumber(DayOfWeek.tue), 2);
    });
    test('Wednesday returns number 3', () {
      expect(getWeekdayNumber(DayOfWeek.wed), 3);
    });
    test('Thursday returns number 4', () {
      expect(getWeekdayNumber(DayOfWeek.thu), 4);
    });
    test('Friday returns number 5', () {
      expect(getWeekdayNumber(DayOfWeek.fri), 5);
    });
    test('Saturday returns number 6', () {
      expect(getWeekdayNumber(DayOfWeek.sat), 6);
    });
    test('Sunday returns number 7', () {
      expect(getWeekdayNumber(DayOfWeek.sun), 7);
    });
  });
  group('The getMonthCount function', () {
    test('Calculates the month when two DateTimes are given.', () {
      final DateTime dateA = DateTime(2022, 06, 30);
      final DateTime dateB = DateTime(2022, 01, 1);

      expect(getMonthCount(dateA, dateB), 5);
    });
  });
  group('Test isSameDay function', () {
    test(
      'Only the time is different and returns true.',
      () {
        final DateTime dateA = DateTime(2022, 06, 15, 3, 27, 30);
        final DateTime dateB = DateTime(2022, 06, 15, 6, 30, 10);

        expect(isSameDay(dateA, dateB), true);
      },
    );
    test('The date is different and returns false.', () {
      final DateTime dateA = DateTime(2022, 06, 15, 13, 40, 30);
      final DateTime dateB = DateTime(2022, 06, 5, 13, 40, 30);

      expect(isSameDay(dateA, dateB), false);
    });
  });
}
