import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSubjectRequest extends WebDataBase
{

  final String CurriculumID;
  final int SubjectType;
  final int TermID;
  final String SubjectName;
  final String SubjectCode;
  final String CourseTutor;
  final String CourseCode;

  WebDataSubjectRequest(StudentData data, {String CurriculumID, int SubjectType = 0, int TermID = 0,
  String SubjectName, String SubjectCode, String CourseTutor, String CourseCode, int CurrentPage = 0})
    : CurriculumID = CurriculumID, SubjectType = SubjectType, TermID = TermID, 
    SubjectName = SubjectName, SubjectCode = SubjectCode, CourseCode = CourseCode, CourseTutor = CourseTutor,
    super.simplified(data.username,
      data.password, data.username, data.currentTraining?.id.toString(), currentPage: CurrentPage, LCID: data.LCID);

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
    json.addAll(super.toJsonMap());
    return json;
  }

}