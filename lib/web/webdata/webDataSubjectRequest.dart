import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataSubjectRequest extends WebDataContainer
{

  @override
  final WebDataBase base;

  final String? CurriculumID;
  final int SubjectType;
  final int TermID;
  final String? SubjectName;
  final String? SubjectCode;
  final String? CourseTutor;
  final String? CourseCode;

  WebDataSubjectRequest(this.base, {String? CurriculumID, int SubjectType = 0, int TermID = 0,
  String? SubjectName, String? SubjectCode, String? CourseTutor, String? CourseCode, int CurrentPage = 0})
    : CurriculumID = CurriculumID, SubjectType = SubjectType, TermID = TermID, 
    SubjectName = SubjectName, SubjectCode = SubjectCode, CourseCode = CourseCode, CourseTutor = CourseTutor;

    @override
  Map<String, dynamic> toJsonMap() 
  {
    var json = <String, dynamic>{
      'filter': <String, dynamic>
      {
        'CurriculumID' : CurriculumID,
        'SubjectType' : SubjectType,
        'TermID' : TermID,
        'SubjectName' : SubjectName,
        'SubjectCode' : SubjectCode,
        'CourseTutor': CourseTutor,
        'CourseCode' : CourseCode
      }
    };
    json.addAll(base.toJsonMap());
    return json;
  }

}