import 'package:flutter/foundation.dart';

abstract class BaseCache<K>
{

  final items = <Object, K>{};

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
      Future.delayed(Duration(minutes: 3), () async { items.remove(key); });
    }

    return item;
  }

  Future<K> getNewItem(Object key);

}