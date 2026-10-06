/// Source of the current time. Everything is stored and compared in UTC.
///
/// Inject a [FixedClock] in tests so freshness and reminder logic is
/// deterministic.
abstract class Clock {
  const Clock();

  DateTime now();
}

class SystemClock extends Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now().toUtc();
}

class FixedClock extends Clock {
  FixedClock(DateTime time) : _time = time.toUtc();

  DateTime _time;

  @override
  DateTime now() => _time;

  void advance(Duration duration) => _time = _time.add(duration);

  set time(DateTime value) => _time = value.toUtc();
}

/// The clock used by services. Replace in tests, never in production code.
Clock clock = const SystemClock();
