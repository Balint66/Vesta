import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataMessageRead extends WebDataContainer
{

  @override
  final WebDataBase base;

  final String id;

  WebDataMessageRead(this.base, this.id);

  @override
  Map<String, dynamic> toJsonMap() {
    var map = <String,dynamic>{'PersonMessageId':id};

    map.addAll(super.toJsonMap());

    return map;

  }

}