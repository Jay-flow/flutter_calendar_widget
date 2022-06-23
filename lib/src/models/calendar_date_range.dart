/// Encapsulates a start and end [DateTime] that represent the range of dates.
///
/// The range includes the [start] and [end] dates.
/// The [start] date must not be after the [end] date.
class CalendarDateRange {
  /// Creates a date range for the given start and end [DateTime].
  CalendarDateRange({
    this.start,
    this.end,
  });

  /// The start of the range of dates.
  DateTime? start;

  /// The end of the range of dates.
  DateTime? end;
}
