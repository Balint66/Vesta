import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/applicationpage/messageDisplay.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataMessages.dart';

class MessageListDisplay extends BgFetchSateFullWidget
{

  @override
  MessageListDisplayState createState() {
    return MessageListDisplayState();
  }

}

class MessageListDisplayState extends BgFetchState<MessageListDisplay>
    with BackgroundFetchingServiceMixin
{

  List<Message> messages = new List<Message>();

  MessageListDisplayState() : super()
  {
    this.timespan = new Duration(hours: 1);
  }

  @override
  Future<void> onUpdate() async
  {
    WebDataMessages resp = await WebServices
        .getMessages(Data.school, StudentData.Instance);
    
    if(resp == null)
      return;


    setState(() {

      this.messages = resp.MessagesList;

    });
    
  }


  @override
  void initState() {
    super.initState();
    FetchManager.register(this);
    FetchManager.fetch();
  }

  @override
  Widget build(BuildContext context) {

    Widget read = new ListView(children: messages.where((item)=>!item.isNew)
        .expand((item){
      return [new Card(child:
      new ListTile(
        title: new Text(item.subject),
        subtitle: new Text(item.senderName),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MessageDisplay
            (item.senderName,item.subject,item.detail)));
        },
      ),
        elevation: 1,
      )];
    }).toList());

    Widget unread = new ListView(children: messages.where((item)=>item.isNew)
        .expand((item){
      return [new Card(child:
      new ListTile(title: new Text(item.subject),
        subtitle: new Text(item.senderName),
        onTap: (){
          WebServices.setRead(Data.school, StudentData.Instance, item.personMessageId);
          setState(() {
            item.setReadState();
          });
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MessageDisplay
            (item.senderName,item.subject,item.detail)));
          onUpdate();
        },
      ),
        elevation: 1,
      )];
    }).toList());

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
                tabs: <Widget>
                [
                  Tab(text: "Olvasatlan",),
                  Tab(text: "Olvasott",)
                ]
            ),
            primary: false,
          ),
          body: TabBarView(children: <Widget>[
            unread,
            read,
          ])
        ),
    );
  }

}