import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/studentBookData.dart';

import 'webDataBase.dart';

class WebDataStudentBook extends WebDataBase
{

  final BaseDataList<StudentBookData> list;

  WebDataStudentBook.fromJson(Map<String, dynamic> json) :
    list = BaseDataList(other: List<Map<String, dynamic>>.from(json['MarkBookList'])
    .expand((i)=>[StudentBookData.fromJson(i)]).toList().cast()),
    super.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap()
  {
    var sup = super.toJsonMap();

    sup.addAll(<String, dynamic>{'MarkBookList':list.expand((element) => [element.toJson()])});

    return sup;
  }

}