import 'dart:core';


abstract class BackgroundFetchingServiceMixin
{

  factory BackgroundFetchingServiceMixin() => null;

  Future<void> onUpdate();

  Duration timespan = new Duration(seconds: 0);
  DateTime lastFetch;

  int get timespanInSec => timespan.inSeconds;

}