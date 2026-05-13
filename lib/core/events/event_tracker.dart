class EventTracker {
  static void track(String eventName, {Map<String, dynamic>? properties}) {
    // TODO: connect analytics service (e.g. Mixpanel, Amplitude)
    // ignore: avoid_print
    print('EVENT: $eventName | PROPS: $properties');
  }
}
