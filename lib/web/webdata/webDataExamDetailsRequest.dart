import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamDetailsRequest extends WebDataBase
{

  final int ExamID;
  final int SubjectID;
  final int ExamType;

  WebDataExamDetailsRequest.studentSimplified(StudentData data, this.ExamID, {this.ExamType = 1, this.SubjectID = 0}) : super.studentSimplified(data);

  @override
    Map<String, dynamic> toJsonMap() {
      
      var ls = <String, dynamic>{
        'filter': <String, dynamic>{
          'ExamID': ExamID,
          'SubjectID': SubjectID,
          'ExamType': ExamType,
        }
      };

      ls.addAll(super.toJsonMap());

      return ls;
    }

}