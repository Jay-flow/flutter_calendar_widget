import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class Event {
  final String title;

  const Event(this.title);
}

class EventDemoScreen extends StatefulWidget {
  const EventDemoScreen({Key? key}) : super(key: key);

  @override
  State<EventDemoScreen> createState() => _EventDemoScreenState();
}

class _EventDemoScreenState extends State<EventDemoScreen> {
  List<Event> _selectedEvents = [];

  EventList<Event> _getEvents() {
    DateTime now = DateTime.now();

    return EventList(
      events: {
        now: [
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single demo screen'),
      ),
      body: SafeArea(
        child: FlutterCalendar(
          selectionMode: FlutterCalendarSelectionMode.single,
          focusedDate: DateTime.now(),
          events: events,
          onDayPressed: (DateTime day) {
            setState(() {
              _selectedEvents = events.get(day);
            });

            logger.d(_selectedEvents);
          },
          onDayLongPressed: (DateTime day) {
            logger.d('[onDayLongPressed] $day');
          },
        ),
      ),
    );
  }
}
