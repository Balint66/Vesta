import 'dart:convert';

class Message
{
  final String subject;
  final DateTime time;
  final String personMessageId;
  final String neptunCode;
  final String senderName;
  bool get isNew => _isNew;
  final String id;
  final String detail;

  bool _isNew;

  Message(this.subject,String time,this.personMessageId,this.neptunCode,
      this.senderName,this._isNew,this.id,this.detail):
        this.time = DateTime.fromMillisecondsSinceEpoch(int.parse(time));

  void setReadState()
  {
    if(_isNew)
      _isNew = false;
  }

  Map<String,dynamic> toJson()
  {
    return <String,dynamic>{
      "Subject" : subject,
      "SendDate" : "\/Date(${time.millisecondsSinceEpoch})",
      "PersonMessageId" : personMessageId,
      "NeptunCode" : neptunCode,
      "Name" : senderName,
      "IsNew" : isNew,
      "Id" : id,
      "Detail" : detail
    };
  }

  static Message fromJsonString(String str)
  {
    return fromJson(json.decode(str));
  }

  static Message fromJson(Map<String,dynamic> json)
  {
    return new Message(json["Subject"],((json["SendDate"] as String)
        .split("(")[1].split(")")[0]),json["PersonMessageId"].toString(),
      json["NeptunCode"],json["Name"],json["IsNew"],json["Id"].toString(),json["Detail"]);
  }

}