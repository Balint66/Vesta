import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataExamDetailsRequest.dart';

class ExamsCache extends BaseCache<ExamDetails>
{

  ExamsCache() : super(ShouldRunTimer: true);

  @override
  Future<ExamDetails> getNewItem(Object key) async
  {
    if(!(key is int))
    {
      throw 'THE KEY TYPE IS INVALID!';
    }
    return (await WebServices.getExamDetails(AccountManager.currentAcount.school,
      WebDataExamDetailsRequest.studentSimplified(AccountManager.currentAcount, key)))!.examDetails;
  }
  
}