import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

import '../mocks/events.dart';
import '../models/event.dart';

class EventDemoScreen extends StatefulWidget {
  const EventDemoScreen({Key? key}) : super(key: key);

  @override
  State<EventDemoScreen> createState() => _EventDemoScreenState();
}

class _EventDemoScreenState extends State<EventDemoScreen> {
  List<Event> _selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    EventList<Event> events = getEventList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event demo screen'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlutterCalendar(
              selectionMode: CalendarSelectionMode.single,
              events: events,
              onDayPressed: (DateTime day) {
                setState(() {
                  _selectedEvents = events.get(day);
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _selectedEvents
                      .map(
                        (event) => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 1),
                          ),
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
