import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/subjectData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSubjectResponse extends WebDataBase
{
  final BaseDataList<SubjectData> list;

    WebDataSubjectResponse.fromJson(Map<String, dynamic> json) :
        list = BaseDataList(other: List<Map<String, dynamic>>.from(json['SubjectList'])
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