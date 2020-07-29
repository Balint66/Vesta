import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataMessageRead extends WebDataBase
{

  final String id;

  WebDataMessageRead(StudentData data, this.id) : super.studentSimplified(data);

  @override
  Map<String, dynamic> toJsonMap() {
    var map = <String,dynamic>{'PersonMessageId':id};

    map.addAll(super.toJsonMap());

    return map;

  }

}