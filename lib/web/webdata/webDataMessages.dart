import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';
import 'webDataBase.dart';

class WebDataMessages extends WebDataContainer
{

  @override
  final WebDataBase base;

  // ignore: non_constant_identifier_names
  final BaseDataList<Message> MessagesList;
  final int NewMessagesNumber;
  final BaseDataList<Message> RequireToReadMessagesList;

  WebDataMessages.fromJson(Map<String, dynamic> json) :
        MessagesList = BaseDataList(other: List<Map<String,dynamic>>.from(json['MessagesList'])
            .map((i)=>Message.fromJson(i)).toList()),
        NewMessagesNumber = json['NewMessagesNumber'],
        RequireToReadMessagesList = BaseDataList(other: List<Map<String,dynamic>>.from(json['RequireToReadMessagesList'])
          .map((i)=>Message.fromJson(i)).toList()),
        base = WebDataBase.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap() {
    var sup = super.toJsonMap();
    sup.addAll(<String, dynamic>{
      'MessagesList' : MessagesList.expand((e){
        return [e!.toJson()];
      })
    });
    return sup;
  }

}