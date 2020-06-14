import 'package:vesta/datastorage/Lists/studentBookDataList.dart';
import 'package:vesta/datastorage/studentBookData.dart';

import 'webDataBase.dart';

class WebDataStudentBook extends WebDataBase
{

  final StudentBookDataList list;

  factory ()=> null;

  WebDataStudentBook._(): this.list = null, super.studentSimplified(null);

  WebDataStudentBook.fromJson(Map<String, dynamic> json) :
    this.list = new StudentBookDataList(other: List<Map<String, dynamic>>.from(json["MarkBookList"])
    .expand((i)=>[StudentBookData.fromJson(i)]).toList().cast()),
    super.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap()
  {
    Map<String, dynamic> sup = super.toJsonMap();

    sup.addAll(<String, dynamic>{"MarkBookList":list.expand((element) => [element.toJson()])});

    return sup;
  }

}