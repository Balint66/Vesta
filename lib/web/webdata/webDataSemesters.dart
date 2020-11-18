import 'package:vesta/datastorage/Lists/semestersDataList.dart';
import 'package:vesta/datastorage/periodData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSemesters extends WebDataBase
{

  final SemestersDataList list;

  WebDataSemesters.fromJson(Map<String, dynamic> json) :
    list = SemestersDataList(other: List<Map<String, dynamic>>.from(json['PeriodList'])
    .expand((i)=>[PeriodData.fromJson(i)]).toList().cast()),
    super.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap()
  {
    var sup = super.toJsonMap();

    sup.addAll(<String, dynamic>{'MarkBookList':list.expand((element) => [element.toJson()])});

    return sup;
  }
}