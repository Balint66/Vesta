import 'package:flutter/foundation.dart';

abstract class BaseCache<K>
{

  final items = <Object, K>{};
  late final bool ShouldRunTimer;
  final int deletionTime;

  BaseCache({required this.ShouldRunTimer, this.deletionTime = 3});

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
      item = await getNewItem(key);
      items[key] = item;
      if(ShouldRunTimer)
      {
        Future.delayed(Duration(minutes: deletionTime), () async { items.remove(key); });
      }
    }

    return item;
  }

  Future<K> getNewItem(Object key);

}