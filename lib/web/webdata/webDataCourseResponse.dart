import 'package:vesta/datastorage/Lists/courseDataList.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCourseResponse extends WebDataBase
{

  factory WebDataCourseResponse() => null;

  final CourseDataList CourseList;

  WebDataCourseResponse._(): CourseList = null, super.studentSimplified(null);

  WebDataCourseResponse.fromJson(Map<String, dynamic> json) :
  CourseList = CourseDataList(other: List<Map<String, dynamic>>.from(json['CourseList'])
  .map((e) => CourseData.fromJson(e)).toList().cast()), super.fromJson(json);

}