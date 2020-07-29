import 'dart:collection';

import 'package:vesta/datastorage/studentBookData.dart';

class StudentBookDataList extends ListBase<StudentBookData> implements List<StudentBookData> 
{
   final List<StudentBookData> _l;

  StudentBookDataList({List<StudentBookData> other}) : _l = other ?? <StudentBookData>[];

  @override
  StudentBookData operator [](int i) => _l[i];
  @override
  void operator []=(int index, StudentBookData value) { _l[index] = value; }

  @override
  set length(int newLength) { _l.length = newLength; }
  @override
  int get length => _l.length;

  @override
  bool contains(Object element)
  {

    if(!(element is StudentBookData)) {
      return false;
    }

    return _l.any((e) => e.ID == (element as StudentBookData).ID);

  }

}