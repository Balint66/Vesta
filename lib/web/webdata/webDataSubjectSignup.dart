import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSubjectSignupRequest extends WebDataBase
{
  final int SubjectID;
  final int CurriculumID;
  final List<int> CourseIDs;
  final bool IsOnSubject;
  final bool SubjectSignin;
  final int TermID;
  final int CurriculumTemplatelineID;
  final List<int> AllType;

  WebDataSubjectSignupRequest(StudentData data, {int SubjectID = 0, int CurriculumID = 0, List<int> CourseIDs = null,
   bool IsOnSubject = false, bool SubjectSignin = false, int TermID = 0, int CurriculumTemplatelineID = 0, List<int> AllType = null}) : 
   this.SubjectID = SubjectID, this.CurriculumID = CurriculumID, this.CourseIDs = CourseIDs == null? [0] : CourseIDs, this.IsOnSubject = IsOnSubject,
    this.SubjectSignin = SubjectSignin, this.TermID = TermID, this.CurriculumTemplatelineID = CurriculumTemplatelineID, this.AllType = AllType,
     super.studentSimplified(data, currentPage: 1);

  @override
  Map<String, dynamic> toJsonMap() 
  {
    Map<String, dynamic> map = <String, dynamic>
    {
      "subjectCourseDatas": <String, dynamic>
      {
        "SubjectID": SubjectID,
        "CurriculumID": CurriculumID,
        "CourseIDs": CourseIDs,
        "IsOnSubject": IsOnSubject,
        "SubjectSignin": SubjectSignin,
      },
      "SubjectType": -1,
      "TermID": TermID,
      "CurriculumTemplatelineID": CurriculumTemplatelineID,
      "AllType": AllType,
    };

    map.addAll(super.toJsonMap());

    return map;

  }

}