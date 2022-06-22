import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

import '../models/event.dart';

EventList<Event> getEventList() {
  DateTime now = DateTime.now();

  return EventList(
    events: {
      DateTime(now.year, now.month, 21): [
        const Event('Event 1'),
        const Event('Event 2'),
        const Event('Event 3'),
        const Event('Event 4'),
        const Event('Event 5'),
        const Event('Event 6'),
      ],
      DateTime(now.year, now.month, 3): [
        const Event('Event 1'),
        const Event('Event 2'),
        const Event('Event 3'),
      ],
      DateTime(now.year, now.month, 10): [
        const Event('Event 1'),
        const Event('Event 2'),
      ],
      DateTime(now.year, now.month, 6): [
        const Event('Event 1'),
        const Event('Event 2'),
      ]
    },
  );
}
