import 'package:flutter_calendar_widget/src/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
