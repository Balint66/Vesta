import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataCourseRequest extends WebDataContainer
{

    @override
    final WebDataBase base;
    
    final int Id;
    final int SubjectType;
    final int CurriculumID;
    final int TermID;

    WebDataCourseRequest(this.base, {int Id = 0, int SubjectType = -1, int CurriculumID = 0, int TermID = 0}) 
    : Id = Id, TermID = TermID, CurriculumID = CurriculumID, SubjectType = SubjectType;

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

      map.addAll(base.toJsonMap());

      return map;

    }

}