import 'dart:collection';

import 'package:vesta/datastorage/periodData.dart';

class SemestersDataList extends ListBase<PeriodData> implements List<PeriodData>
{
  final List<PeriodData> _l;

  SemestersDataList({List<PeriodData> other}) : this._l = other != null ? other :
    new List<PeriodData>();

  PeriodData operator [](int i) => _l[i];
  void operator []=(int index, PeriodData value) { _l[index] = value; }

  set length(int newLength) { _l.length = newLength; }
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is PeriodData))
      return false;

    var obj = element as PeriodData;

    return this.any((e) => e.PeriodTypeName == obj.PeriodTypeName && e.FromDate == obj.FromDate 
      && e.ToDate == obj.ToDate && e.TrainingtermIntervalId == obj.TrainingtermIntervalId);
  }
}