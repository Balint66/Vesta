import 'dart:core';


abstract class BackgroundFetchingServiceMixin
{

  factory BackgroundFetchingServiceMixin() => null;

  Future<void> onUpdate();

  Duration get timespan;
  DateTime lastFetch;

  int get timespanInSec => timespan.inSeconds;

}