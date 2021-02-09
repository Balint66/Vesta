import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/utils/DateUtil.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamRequest extends WebDataBase
{
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
  WebDataExamRequest.studentSimplified(AccountData data, {this.ExamType = 0, this.Term = 0, this.SubjectID = 0, DateTime? ExamStart, this.ExamTypeSpinner = 0,
    this.IsFromSearch = true, this.SubjectName, this.SubjectCode, this.CourseCode, this.KurzusOktato}) 
    : ExamStart = ExamStart ?? DateTime.fromMillisecondsSinceEpoch(-62135596800000, isUtc: true), super.studentSimplified(data);

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
        map.addAll(super.toJsonMap());
        return map;
      }

}