import 'package:vesta/datastorage/Lists/cache/baseCache.dart';

class EventCache extends BaseCache
{

  EventCache() : super(ShouldRunTimer: true);

  @override
  Future getNewItem(Object key) {
    // TODO: implement getNewItem
    throw UnimplementedError();
  }
  
}