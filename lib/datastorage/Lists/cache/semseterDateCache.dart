import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class SemesterDateCache extends BaseCache<List<Map<String, dynamic>>>
{
  SemesterDateCache() : super(ShouldRunTimer: false);

  @override
  Future<List<Map<String, dynamic>>> getNewItem(Object key) async {
    if(!(key is String) && key != 'trainingList')
    {
      throw 'THE KEY TYPE IS INVALID!';
    }

    return await WebServices.getPeriodTerms(AccountManager.currentAcount.school,
      WebDataBase.studentSimplified(AccountManager.currentAcount));
    
  }
  
}