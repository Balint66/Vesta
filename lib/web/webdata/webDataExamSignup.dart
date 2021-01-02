import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamSignup extends WebDataBase
{

  final String ExamIdentifier;
  final int CourseID;
  final int TermID;
  final int ExamID;
  final int? SubjectID;
  final int ExamType;

  WebDataExamSignup(StudentData data, this.CourseID, this.ExamID,
  {this.ExamIdentifier = '', this.TermID = 0, this.SubjectID, this.ExamType = 0}) : super.studentSimplified(data);

  @override
    Map<String, dynamic> toJsonMap() {
      var ls = <String, dynamic>{
        'filter':
        {
          'ExamIdentifier':ExamIdentifier,
          'CourseID': CourseID,
          'TermID': TermID,
          'ExamID': ExamID,
          'SubjectID': SubjectID,
          'ExamType': ExamType
        }
      };
      ls.addAll(super.toJsonMap());
      return ls;
    }
  
}