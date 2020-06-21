import 'dart:collection';

import 'package:vesta/datastorage/subjectData.dart';

class SubjectDataList extends ListBase<SubjectData> implements List<SubjectData> 
{
  final List<SubjectData> _l;

  SubjectDataList({List<SubjectData> other}) : this._l = other != null ? other :
    new List<SubjectData>();

  SubjectData operator [](int i) => _l[i];
  void operator []=(int index, SubjectData value) { _l[index] = value; }

  set length(int newLength) { _l.length = newLength; }
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is SubjectData))
      return false;

    var obj = element as SubjectData;

    return this.any((e) => e.SubjectName == obj.SubjectName && e.SubjectId == obj.SubjectId); //TODO: Better implementation?
  }
}