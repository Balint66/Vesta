import 'package:vesta/utils/DateUtil.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataExamRequest extends WebDataContainer
{

  @override
  final WebDataBase base;

  final int ExamType;
  final int Term;
  final int SubjectID;
  final DateTime ExamStart;
  final int ExamTypeSpinner;
  final bool IsFromSearch;
  final String? SubjectName;
  final String? SubjectCode;
  final String? CourseCode;
  final String? KurzusOktato;
  WebDataExamRequest.studentSimplified(this.base, {this.ExamType = 0, this.Term = 0, this.SubjectID = 0, DateTime? ExamStart, this.ExamTypeSpinner = 0,
    this.IsFromSearch = true, this.SubjectName, this.SubjectCode, this.CourseCode, this.KurzusOktato}) 
    : ExamStart = ExamStart ?? DateTime.fromMillisecondsSinceEpoch(-62135596800000, isUtc: true);

    @override
      Map<String, dynamic> toJsonMap() {
        var map = <String, dynamic>{
          'filter':<String, dynamic>{
            'ExamType': ExamType,
            'Term': Term,
            'SubjectID': SubjectID,
            'ExamStart': '\/Date('
          + DateUtil.epochFlooredToDays(ExamStart).toString() + ')\/',
            'ExamTypeSpinner': ExamTypeSpinner,
            'IsFromSearch': IsFromSearch,
            'SubjectName': SubjectName,
            'SubjectCode': SubjectCode,
            'CourseCode': CourseCode,
            'KurzusOktato': KurzusOktato,
          }
        };
        map.addAll(base.toJsonMap());
        return map;
      }

}