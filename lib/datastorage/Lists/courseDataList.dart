import 'dart:collection';

import 'package:vesta/datastorage/courseData.dart';

class CourseDataList extends ListBase<CourseData> implements List<CourseData>
{
  final List<CourseData> _l;

  CourseDataList({List<CourseData> other}) : _l = other ?? <CourseData>[];

  @override
  CourseData operator [](int i) => _l[i];
  @override
  void operator []=(int index, CourseData value) { _l[index] = value; }

  @override
  set length(int newLength) { _l.length = newLength; }
  @override
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is CourseData)) {
      return false;
    }
    return any((e) => e.Id == (element as CourseData).Id && e.CourseCode == (element as CourseData).CourseCode);
  }
}