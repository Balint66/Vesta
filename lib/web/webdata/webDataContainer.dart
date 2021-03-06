import 'dart:convert';

import 'package:vesta/web/webdata/iWebData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

abstract class WebDataContainer extends IWebData
{
  WebDataBase get base;
}

class SimpleConatiner implements WebDataContainer
{
  @override
  final WebDataBase base;

  SimpleConatiner(this.base);
  
  @override
  Map<String, dynamic> toJsonMap() => base.toJsonMap();

  @override
  String toJson() =>
    json.encode(toJsonMap());

  factory SimpleConatiner.fromJson(Map<String, dynamic> json)
  {
    var base = WebDataBase.fromJson(json);
    return SimpleConatiner(base);
  }
  
}