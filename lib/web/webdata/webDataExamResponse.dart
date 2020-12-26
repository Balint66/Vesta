import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/examData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamResponse extends WebDataBase
{

  final BaseDataList<Exam> exams;

  WebDataExamResponse.fromJson(Map<String, dynamic> json, int filterType) :
  exams = BaseDataList(other: (json['ExamList'] as List<dynamic>).cast<Map<String, dynamic>>().map((e)=> Exam.fromJson(e, filterType)).toList()), super.fromJson(json);

}