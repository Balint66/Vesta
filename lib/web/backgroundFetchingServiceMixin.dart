import 'dart:core';


abstract class BackgroundFetchingServiceMixin
{

  factory BackgroundFetchingServiceMixin() => null;

  Future<void> onUpdate();

  final Duration timespan = new Duration();
  DateTime lastFetch;

  int get timespanInSec => timespan.inSeconds;

}