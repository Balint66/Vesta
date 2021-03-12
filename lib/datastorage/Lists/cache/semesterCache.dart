import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/periodData.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataSemestersRequest.dart';

class SemesterCache extends BaseCache<BaseDataList<PeriodData>>
{

  SemesterCache() : super(ShouldRunTimer: true, deletionTime: 60*24);

  @override
  Future<BaseDataList<PeriodData>> getNewItem(Object key) async
  {
    if(!(key is int))
    {
      throw 'THE KEY TYPE IS INVALID!';
    }

    return (await WebServices.getSemestersData(AccountManager.currentAcount.school,
      WebDataSemestersRequest(AccountManager.currentAcount.webBase, PeriodTermID: key)))!.list;

  }
  
}