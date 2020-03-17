import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/applicationpage/messages/messageDisplay.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataMessages.dart';

class MessageListDisplay extends BgFetchSateFullWidget
{

  MessageListDisplay({Key key}):super(key:key);

  @override
  MessageListDisplayState createState() {
    return MessageListDisplayState();
  }

}

class MessageListDisplayState extends BgFetchState<MessageListDisplay>
    with BackgroundFetchingServiceMixin
{

  List<Message> _messages;

  Future<List<Message>> get messages async
  {
    await Future.delayed(new Duration(seconds: 1), () async =>
    await Future.doWhile(() async
    {
      await Future.delayed(new Duration(seconds: 1));
      return _messages == null;
    }));

    return _messages;

  }

  MessageListDisplayState() : super()
  {
    this.timespan = new Duration(hours: 1);
  }

  @override
  Future<void> onUpdate() async
  {

    if(!mounted)
      return;

    WebDataMessages resp = await WebServices
        .getMessages(Data.school, StudentData.Instance);
    
    if(resp == null)
      return;


    if(!mounted)
      return;

    setState(() {

      this._messages = resp.MessagesList;

    });
    
  }

  @override
  Widget build(BuildContext context)
  {

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
          body: FutureBuilder( future: messages,
              builder: (BuildContext context, AsyncSnapshot<List<Message>> snap)
              {
                if(snap.hasData)
                {

                  Widget read = new SortedMesages(_messages.where((item)=>!item.isNew).toList(),
                    (item){
                      MainProgramState.of(context).push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                      (item.senderName,item.subject,item.detail)));
                  });

                  Widget unread = new SortedMesages(_messages.where((item)=>item.isNew).toList(),
                        (item) {
                        WebServices.setRead(Data.school, StudentData.Instance, item.personMessageId);
                        setState(() {
                          item.setReadState();
                        });
                        MainProgramState.of(context).push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                          (item.senderName,item.subject,item.detail)));
                        onUpdate();
                      });

                return TabBarView(children: <Widget>[
                  unread,
                  read,
                  ]);
                }
                  return new TabBarView(children: <Widget>[
                    new Center(child: new CircularProgressIndicator()),
                    new Center(child: new  CircularProgressIndicator())
                  ],);
                }
          )
        ),
    );
  }

}

typedef displayFunction = void Function(Message item);

class SortedMesages extends StatelessWidget
{

  final List<Message> _messages;
  final displayFunction _ontap;

  SortedMesages(List<Message> msg, displayFunction onTap) : this._messages = msg,
        this._ontap = onTap,  super();

  @override
  Widget build(BuildContext context)
  {
    return new ListView(
      children: List.of( _messages.map  ((item) => new Card(child:
          new ListTile(title: new Text(item.subject),
            subtitle: new Text(item.senderName),
            onTap: () => _ontap(item),
          ),
            elevation: 1,
          ),
        )
      )
    );
  }

}