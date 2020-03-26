import 'package:vesta/datastorage/message.dart';
import 'package:vesta/datastorage/Lists/messagesList.dart';
import 'webDataBase.dart';

class WebDataMessages extends WebDataBase
{

  // ignore: non_constant_identifier_names
  final MessageList MessagesList;

  factory()=> null;

  WebDataMessages._(): this.MessagesList = null, super.studentSimplified(null); // ignore: unused_element

  WebDataMessages.fromJson(Map<String, dynamic> json) :
        this.MessagesList = new MessageList(other: List<Map<String,dynamic>>.from(json["MessagesList"])
            .expand((i)=>[Message.fromJson(i)]).toList()),
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