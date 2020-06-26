import 'package:vesta/datastorage/Lists/courseDataList.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCourseResponse extends WebDataBase
{

  factory() => null;

  final CourseDataList CourseList;

  WebDataCourseResponse._(): this.CourseList = null, super.studentSimplified(null);

  WebDataCourseResponse.fromJson(Map<String, dynamic> json) :
  this.CourseList = new CourseDataList(other: List<Map<String, dynamic>>.from(json["CourseList"])
  .map((e) => new CourseData.fromJson(e)).toList().cast()), super.fromJson(json);

}