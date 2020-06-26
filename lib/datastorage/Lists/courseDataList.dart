import 'dart:collection';

import 'package:vesta/datastorage/courseData.dart';

class CourseDataList extends ListBase<CourseData> implements List<CourseData>
{
  final List<CourseData> _l;

  CourseDataList({List<CourseData> other}) : this._l = other != null ? other :
    new List<CourseData>();

  CourseData operator [](int i) => _l[i];
  void operator []=(int index, CourseData value) { _l[index] = value; }

  set length(int newLength) { _l.length = newLength; }
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is CourseData))
      return false;
    return this.any((e) => e == element); // TODO: Better implementation
  }
}