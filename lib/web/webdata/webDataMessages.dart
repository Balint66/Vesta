import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/message.dart';
import 'webDataBase.dart';

class WebDataMessages extends WebDataBase
{

  // ignore: non_constant_identifier_names
  final BaseDataList<Message> MessagesList;

  WebDataMessages.fromJson(Map<String, dynamic> json) :
        MessagesList = BaseDataList(other: List<Map<String,dynamic>>.from(json['MessagesList'])
            .expand((i)=>[Message.fromJson(i)]).toList()),
        super.fromJson(remove<String, dynamic>(json, 'MessagesList'));

  @override
  Map<String, dynamic> toJsonMap() {
    var sup = super.toJsonMap();
    sup.addAll(<String, dynamic>{
      'MessagesList' : MessagesList.expand((e){
        return [e.toJson()];
      })
    });
    return sup;
  }

}