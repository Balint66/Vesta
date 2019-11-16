class Message
{
  final String subject;
  final DateTime time;
  final String personMessageId;
  final String neptunCode;
  final String senderName;
  final bool isNew;
  final String id;
  final String Detail;

  Message(this.subject,String time,this.personMessageId,this.neptunCode,this.senderName,this.isNew,this.id,this.Detail): this.time = DateTime.fromMillisecondsSinceEpoch(int.parse(time));

}