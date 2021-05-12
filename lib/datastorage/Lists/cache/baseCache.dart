import 'package:flutter/foundation.dart';
import 'package:vesta/datastorage/acountData.dart';

abstract class BaseCache<K>
{

  final AccountData _account;
  final items = <Object, K>{};
  late final bool ShouldRunTimer;
  final int deletionTime;

  BaseCache(this._account, {required this.ShouldRunTimer, this.deletionTime = 3});

  @nonVirtual
  Future<K> getItem(Object key) async
  {
    late K item;

    if(items.containsKey(key))
    {
      item = items[key]!;
    }
    else
    {
      item = await getNewItem(key, _account);
      items[key] = item;
      if(ShouldRunTimer)
      {
        Future.delayed(Duration(minutes: deletionTime), () async { items.remove(key); });
      }
    }

    return item;
  }

  Future<K> getNewItem(Object key, AccountData account);

}