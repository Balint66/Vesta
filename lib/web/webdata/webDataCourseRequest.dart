import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCourseRequest extends WebDataBase
{
    final int Id;
    final int SubjectType;
    final int CurriculumID;
    final int TermID;

    WebDataCourseRequest(AccountData data, {int Id = 0, int SubjectType = -1, int CurriculumID = 0, int TermID = 0}) 
    : Id = Id, TermID = TermID, CurriculumID = CurriculumID, SubjectType = SubjectType, super.studentSimplified(data);

    @override
    Map<String, dynamic> toJsonMap()
    {

      var map = <String, dynamic>
      {
        'filter': <String, dynamic>
        {
          'Id': Id,
          'SubjectType' : SubjectType,
          'CurriculumID' : CurriculumID,
          'TermID' : TermID
        }
      };

      map.addAll(super.toJsonMap());

      return map;

    }

}