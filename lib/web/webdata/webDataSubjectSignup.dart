import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataSubjectSignupRequest extends WebDataContainer
{

  @override
  final WebDataBase base;

  final int SubjectID;
  final int CurriculumID;
  final List<int> CourseIDs;
  final bool IsOnSubject;
  final bool SubjectSignin;
  final int TermID;
  final int CurriculumTemplatelineID;
  final List<int> AllType;

  WebDataSubjectSignupRequest(this.base, {int SubjectID = 0, int CurriculumID = 0, List<int>? CourseIDs,
  bool IsOnSubject = false, bool SubjectSignin = false, int TermID = 0, int CurriculumTemplatelineID = 0, List<int>? AllType}) : 
  SubjectID = SubjectID, CurriculumID = CurriculumID, CourseIDs = CourseIDs ?? [0], IsOnSubject = IsOnSubject,
    SubjectSignin = SubjectSignin, TermID = TermID, CurriculumTemplatelineID = CurriculumTemplatelineID, AllType = AllType ?? <int>[];

  @override
  Map<String, dynamic> toJsonMap() 
  {
    var map = <String, dynamic>
    {
      'subjectCourseDatas': <String, dynamic>
      {
        'SubjectID': SubjectID,
        'CurriculumID': CurriculumID,
        'CourseIDs': CourseIDs,
        'IsOnSubject': IsOnSubject,
        'SubjectSignin': SubjectSignin,
      },
      'SubjectType': -1,
      'TermID': TermID,
      'CurriculumTemplatelineID': CurriculumTemplatelineID,
      'AllType': AllType,
    };

    map.addAll(base.toJsonMap());

    return map;

  }

}