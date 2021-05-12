import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class SemesterDateCache extends BaseCache<List<Map<String, dynamic>>>
{
  SemesterDateCache(AccountData account) : super(account, ShouldRunTimer: false);

  @override
  Future<List<Map<String, dynamic>>> getNewItem(Object key, AccountData account) async {
    if(!(key is String) && key != 'trainingList')
    {
      throw 'THE KEY TYPE IS INVALID!';
    }

    return await WebServices.getPeriodTerms(account.school,
      SimpleConatiner(account.webBase));
    
  }
  
}