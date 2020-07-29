import 'package:vesta/datastorage/Lists/subjectDataList.dart';
import 'package:vesta/datastorage/subjectData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSubjectResponse extends WebDataBase
{
  final SubjectDataList list;

    WebDataSubjectResponse.fromJson(Map<String, dynamic> json) :
        list = SubjectDataList(other: List<Map<String, dynamic>>.from(json['SubjectList'])
        .expand((i)=>[SubjectData.fromJson(i)]).toList().cast()),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap()
  {
    var sup = super.toJsonMap();

    sup.addAll(<String, dynamic>{'SubjectList':list.expand((element) => [element.toJson()])});

    return sup;
  }

}