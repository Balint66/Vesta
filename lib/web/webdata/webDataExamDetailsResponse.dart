import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamDetailsResponse extends WebDataBase
{

  final ExamDetails examDetails;

  WebDataExamDetailsResponse.fromJson(Map<String, dynamic> json) : examDetails = ExamDetails.fromJson(json['ExamDetails']) , super.fromJson(json);

}