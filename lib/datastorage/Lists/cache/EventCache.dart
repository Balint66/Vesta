import 'package:vesta/datastorage/Lists/cache/baseCache.dart';
import 'package:vesta/datastorage/acountData.dart';

class EventCache extends BaseCache
{

  EventCache(AccountData account) : super( account, ShouldRunTimer: true);

  @override
  Future getNewItem(Object key, AccountData account) {
    // TODO: implement getNewItem
    throw UnimplementedError();
  }
  
}