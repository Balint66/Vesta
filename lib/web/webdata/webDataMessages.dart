import 'package:vesta/datastorage/message.dart';
import 'webDataBase.dart';

class WebDataMessages extends WebDataBase
{

  final List<Message> MessagesList;

  WebDataMessages.fromJson(Map<String, dynamic> json) :
        this.MessagesList = List<Map<String,dynamic>>.from(json["MessagesList"])
            .expand((i)=>[Message.fromJson(i)]).toList(),
        super.fromJson(remove<String, dynamic>(json, "MessagesList"));

  @override
  Map<String, dynamic> toJsonMap() {
    Map<String, dynamic> sup = super.toJsonMap();
    sup.addAll(<String, dynamic>{
      "MessagesList" : MessagesList.expand((e){
        return [e.toJson()];
      })
    });
    return sup;
  }

}