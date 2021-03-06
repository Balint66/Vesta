import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/studentBookData.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

import 'webDataBase.dart';

class WebDataStudentBook extends WebDataContainer
{

  @override
  final WebDataBase base;

  final BaseDataList<StudentBookData> list;

  WebDataStudentBook.fromJson(Map<String, dynamic> json) :
    list = BaseDataList(other: List<Map<String, dynamic>>.from(json['MarkBookList'])
    .expand((i)=>[StudentBookData.fromJson(i)]).toList().cast()),
    base = WebDataBase.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap()
  {
    var sup = base.toJsonMap();

    sup.addAll(<String, dynamic>{'MarkBookList':list.expand((element) => [element.toJson()])});

    return sup;
  }

}