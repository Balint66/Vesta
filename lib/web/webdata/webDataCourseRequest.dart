import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCourseRequest extends WebDataBase
{
    final int Id;
    final int SubjectType;
    final int CurriculumID;
    final int TermID;

    WebDataCourseRequest(StudentData data, {int Id = 0, int SubjectType = -1, int CurriculumID = 0, int TermID = 0}) 
    : this.Id = Id, this.TermID = TermID, this.CurriculumID = CurriculumID, this.SubjectType = SubjectType, super.studentSimplified(data);

    @override
    Map<String, dynamic> toJsonMap()
    {

      Map<String, dynamic> map = <String, dynamic>
      {
        "filter": <String, dynamic>
        {
          "Id": Id,
          "SubjectType" : SubjectType,
          "CurriculumID" : CurriculumID,
          "TermID" : TermID
        }
      };

      map.addAll(super.toJsonMap());

      return map;

    }

}