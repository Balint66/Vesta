import 'package:vesta/datastorage/Lists/semestersDataList.dart';
import 'package:vesta/datastorage/periodData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSemesters extends WebDataBase
{
  factory ()=> null;

  final SemestersDataList list;

  WebDataSemesters._(): this.list = null, super.studentSimplified(null);

  WebDataSemesters.fromJson(Map<String, dynamic> json) :
    this.list = new SemestersDataList(other: List<Map<String, dynamic>>.from(json["PeriodList"])
    .expand((i)=>[PeriodData.fromJson(i)]).toList().cast()),
    super.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap()
  {
    Map<String, dynamic> sup = super.toJsonMap();

    sup.addAll(<String, dynamic>{"MarkBookList":list.expand((element) => [element.toJson()])});

    return sup;
  }
}