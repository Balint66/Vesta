import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataExamDetailsRequest.dart';

class ExamsCache extends BaseCache<ExamDetails>
{
  @override
  Future<ExamDetails> getNewItem(Object key) async
  {
    if(!(key is int))
    {
      throw 'THE KEY TYPE IS INVALID!';
    }
    return (await WebServices.getExamDetails(Data.school!, WebDataExamDetailsRequest.studentSimplified(StudentData.Instance!, key)))!.examDetails;
  }
  
}