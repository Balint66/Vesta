import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';
import 'package:vesta/web/webdata/iWebData.dart';
import 'webDataBase.dart';

class WebDataMessages extends WebDataContainer
{

  @override
  final WebDataBase base;

  // ignore: non_constant_identifier_names
  final BaseDataList<Message> MessagesList;

  WebDataMessages.fromJson(Map<String, dynamic> json) :
        MessagesList = BaseDataList(other: List<Map<String,dynamic>>.from(json['MessagesList'])
            .expand((i)=>[Message.fromJson(i)]).toList()),
        base = WebDataBase.fromJson(json.mapRemove('MessagesList'));

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