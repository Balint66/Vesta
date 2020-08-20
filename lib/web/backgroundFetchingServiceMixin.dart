import 'dart:core';


mixin BackgroundFetchingServiceMixin
{

  Future<void> onUpdate();

  Duration get timespan;
  DateTime lastFetch;

  bool get enabled;

  int get timespanInSec => timespan.inSeconds;

}