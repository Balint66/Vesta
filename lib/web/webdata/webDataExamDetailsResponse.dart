import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataExamDetailsResponse extends WebDataContainer
{

  @override
  final WebDataBase base;

  final ExamDetails examDetails;

  WebDataExamDetailsResponse.fromJson(Map<String, dynamic> json) 
    : examDetails = ExamDetails.fromJson(json['ExamDetails']) , base = WebDataBase.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap() 
  {
    throw UnimplementedError();
  }

}