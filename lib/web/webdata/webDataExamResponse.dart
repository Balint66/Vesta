import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/examData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataExamResponse extends WebDataContainer
{

  @override
  final WebDataBase base;

  final BaseDataList<Exam> exams;

  WebDataExamResponse.fromJson(Map<String, dynamic> json, int filterType) :
  exams = BaseDataList(other: (json['ExamList'] as List<dynamic>).cast<Map<String, dynamic>>().map((e)=> Exam.fromJson(e, filterType)).toList()),
  base = WebDataBase.fromJson(json);

  @override
  // ignore: must_call_super
  Map<String, dynamic> toJsonMap() =>
    throw UnimplementedError();

}