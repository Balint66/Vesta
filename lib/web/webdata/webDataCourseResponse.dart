import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataCourseResponse extends WebDataContainer
{

  @override
  final WebDataBase base;

  final BaseDataList<CourseData> CourseList;

  WebDataCourseResponse.fromJson(Map<String, dynamic> json) :
  CourseList = BaseDataList(other: List<Map<String, dynamic>>.from(json['CourseList'])
  .map((e) => CourseData.fromJson(e)).toList().cast()), base = WebDataBase.fromJson(json);

  @override
  // ignore: must_call_super
  Map<String, dynamic> toJsonMap() 
  {
    throw UnimplementedError();
  }

}