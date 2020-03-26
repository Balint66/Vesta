import 'dart:collection';

import 'package:vesta/datastorage/calendarData.dart';

class CalendarDataList extends ListBase<CalendarData> implements List<CalendarData>
{

  final List<CalendarData> _l;

  CalendarDataList({List<CalendarData> other}) : this._l = other != null ? other
      : new List<CalendarData>();

  CalendarData operator [](int i) => _l[i];
  void operator []=(int index, CalendarData value) { _l[index] = value; }

  set length(int newLength) { _l.length = newLength; }
  int get length => _l.length;

  @override
  bool contains(Object element)
  {

    if(!(element is CalendarData))
      return false;

    return this.any((e) => e.id == (element as CalendarData).id
        && e.start == (element as CalendarData).start
        && e.end == (element as CalendarData).end);

  }

}