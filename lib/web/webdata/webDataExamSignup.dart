import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataExamSignup extends WebDataContainer
{

  @override
  final WebDataBase base;

  final String ExamIdentifier;
  final int CourseID;
  final int TermID;
  final int ExamID;
  final int? SubjectID;
  final int ExamType;

  WebDataExamSignup(this.base, this.CourseID, this.ExamID,
  {this.ExamIdentifier = '', this.TermID = 0, this.SubjectID, this.ExamType = 0});

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
      ls.addAll(base.toJsonMap());
      return ls;
    }
  
}