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

  WebDataSubjectRequest(StudentData data, {String CurriculumID = null, int SubjectType = 0, int TermID = 0,
   String SubjectName = null, String SubjectCode = null, String CourseTutor = null, String CourseCode = null, int CurrentPage = 0})
    : this.CurriculumID = CurriculumID, this.SubjectType = SubjectType, this.TermID = TermID, 
    this.SubjectName = SubjectName, this.SubjectCode = SubjectCode, this.CourseCode = CourseCode, this.CourseTutor = CourseTutor,
     super.simplified(data.username,
      data.password, data.username, data.currentTraining?.id.toString(), currentPage: CurrentPage);

    @override
  Map<String, dynamic> toJsonMap() 
  {
    Map<String, dynamic> json = <String, dynamic>{
      "filter": <String, dynamic>
      {
        "CurriculumID" : CurriculumID,
        "SubjectType" : SubjectType,
        "TermID" : TermID,
        "SubjectName" : SubjectName,
        "SubjectCode" : SubjectCode,
        "CourseTutor": CourseTutor,
        "CourseCode" : CourseCode
      }
    };
    json.addAll(super.toJsonMap());
    return json;
  }

}