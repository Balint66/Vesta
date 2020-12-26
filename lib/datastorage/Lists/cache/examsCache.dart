import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataExamDetailsRequest.dart';
import 'package:vesta/web/webdata/webDataExamDetailsResponse.dart';

class ExamsCache extends BaseCache<ExamDetails>
{
  @override
  Future<ExamDetails> getNewItem(Object key) async
  {
    if(!(key is String) || int.tryParse(key) == null)
    {
      throw 'THE KEY TYPE IS INVALID!';
    }
    return (await WebServices.getExamDetails(Data.school!, WebDataExamDetailsRequest.studentSimplified(StudentData.Instance, int.parse(key))))!.examDetails;
  }
  
}