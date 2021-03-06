import 'dart:convert';

import 'package:flutter/foundation.dart';

abstract class IWebData
{

  IWebData.fromJson(Map<String, dynamic> json);
  IWebData();
  
  @nonVirtual
  String toJson()
  {
    return json.encode(toJsonMap());
  }

  @mustCallSuper
  Map<String, dynamic> toJsonMap();
}

extension MExtension<T, V> on Map<T, V>
{
  Map<T,V> mapRemove(T key)
  {
    remove(key);
    return this;
  }

}