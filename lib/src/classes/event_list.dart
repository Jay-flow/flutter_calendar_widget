/// The event list for containing events.
///
/// ```dart
/// EventList<Event> getEventList() {
///  return EventList(
///     events: {
///       DateTime(2022, 6, 7): [
///         const Event('Event 1'),
///       ],
///  )
/// }
/// ```
/// See also:
/// [Demo](https://github.com/dooboolab/flutter_calendar_widget/blob/main/example/lib/screens/event_demo_screen.dart)
class EventList<T> {
  late Map<DateTime, List<T>> events;

  EventList({required Map<DateTime, List<T>> events}) {
    Map<DateTime, List<T>> inputEvents = {};
    events.forEach((key, value) {
      inputEvents[dateTimeToDate(key)] = value;
    });

    this.events = inputEvents;
  }

  dateTimeToDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  void add(DateTime date, T event) {
    final eventsOfDate = events[date];

    if (eventsOfDate == null) {
      events[date] = [event];
      return;
    }

    eventsOfDate.add(event);
  }

  void addAll(DateTime date, List<T> events) {
    final eventsOfDate = this.events[date];

    if (eventsOfDate == null) {
      this.events[date] = events;
      return;
    }

    eventsOfDate.addAll(events);
  }

  bool remove(DateTime date, T event) {
    final eventsOfDate = events[date];
    return eventsOfDate != null ? eventsOfDate.remove(event) : false;
  }

  List<T> removeAll(DateTime date) {
    return events.remove(date) ?? [];
  }

  void clear() {
    events.clear();
  }

  List<T> get(DateTime date) {
    return events[date] ?? [];
  }
}
