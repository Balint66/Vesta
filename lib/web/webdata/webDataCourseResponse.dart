import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCourseResponse extends WebDataBase
{

  final BaseDataList<CourseData> CourseList;

  WebDataCourseResponse.fromJson(Map<String, dynamic> json) :
  CourseList = BaseDataList(other: List<Map<String, dynamic>>.from(json['CourseList'])
  .map((e) => CourseData.fromJson(e)).toList().cast()), super.fromJson(json);

}