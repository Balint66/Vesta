import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataExamDetailsRequest.dart';

class ExamsCache extends BaseCache<ExamDetails>
{

  ExamsCache(AccountData account) : super( account, ShouldRunTimer: true);

  @override
  Future<ExamDetails> getNewItem(Object key, AccountData account) async
  {
    if(!(key is int))
    {
      throw 'THE KEY TYPE IS INVALID!';
    }
    return (await WebServices.getExamDetails(account.school,
      WebDataExamDetailsRequest.studentSimplified(account.webBase, key)))!.examDetails;
  }
  
}