import 'dart:collection';

import 'package:vesta/datastorage/calendarData.dart';

class CalendarDataList extends ListBase<CalendarData> implements List<CalendarData>
{

  final List<CalendarData> _l;

  CalendarDataList({List<CalendarData> other}) : _l = other ?? <CalendarData>[];

  @override
  CalendarData operator [](int i) => _l[i];
  @override
  void operator []=(int index, CalendarData value) { _l[index] = value; }

  @override
  set length(int newLength) { _l.length = newLength; }
  @override
  int get length => _l.length;

  @override
  bool contains(Object element)
  {

    if(!(element is CalendarData)) {
      return false;
    }

    return any((e) => e.id == (element as CalendarData).id
        && e.start == (element as CalendarData).start
        && e.end == (element as CalendarData).end);

  }

}