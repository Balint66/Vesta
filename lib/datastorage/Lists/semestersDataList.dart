import 'dart:collection';

import 'package:vesta/datastorage/periodData.dart';

class SemestersDataList extends ListBase<PeriodData> implements List<PeriodData>
{
  final List<PeriodData> _l;

  SemestersDataList({List<PeriodData> other}) : _l = other ?? <PeriodData>[];

  @override
  PeriodData operator [](int i) => _l[i];
  @override
  void operator []=(int index, PeriodData value) { _l[index] = value; }

  @override
  set length(int newLength) { _l.length = newLength; }
  @override
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is PeriodData)) {
      return false;
    }

    var obj = element as PeriodData;

    return any((e) => e.PeriodTypeName == obj.PeriodTypeName && e.FromDate == obj.FromDate 
      && e.ToDate == obj.ToDate && e.TrainingtermIntervalId == obj.TrainingtermIntervalId);
  }
}