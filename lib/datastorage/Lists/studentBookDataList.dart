import 'dart:collection';

import 'package:vesta/datastorage/studentBookData.dart';

class StudentBookDataList extends ListBase<StudentBookData> implements List<StudentBookData> 
{
   final List<StudentBookData> _l;

  StudentBookDataList({List<StudentBookData> other}) : this._l = other != null ? other
      : new List<StudentBookData>();

  StudentBookData operator [](int i) => _l[i];
  void operator []=(int index, StudentBookData value) { _l[index] = value; }

  set length(int newLength) { _l.length = newLength; }
  int get length => _l.length;

  @override
  bool contains(Object element)
  {

    if(!(element is StudentBookData))
      return false;

    return this._l.any((e) => e.ID == (element as StudentBookData).ID);

  }

}