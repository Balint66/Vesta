import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/refreshExecuter.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/applicationpage/messages/messageDisplay.dart';
import 'package:vesta/datastorage/Lists/messagesList.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataMessageRead.dart';

class MessageListDisplay extends BgFetchSateFullWidget
{

  MessageListDisplay({Key key}):super(key:key);

  @override
  MessageListDisplayState createState() {
    return MessageListDisplayState();
  }

}

class MessageListDisplayState extends BgFetchState<MessageListDisplay>
{

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
                  Tab(text: AppTranslations.of(context).translate("messages_unread"),),
                  Tab(text: AppTranslations.of(context).translate("messages_read"),)
                ]
            ),
            primary: false,
          ),
          body: StreamBuilder(
              stream: MainProgramState.of(context).messageList.getData(),
              builder: (BuildContext context, AsyncSnapshot<MessageList> snap)
              {
                if(snap.hasData)
                {

                  Widget read =  new SortedMessages((snap.data
                      .where((item)=>!item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time))),
                    (item){
                      MainProgramState.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                      (item.senderName,item.subject,item.detail)));
                  });

                  Widget unread =new SortedMessages((snap.data
                      .where((item)=>item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time))),
                        (item) {
                          Vesta.logger.d("Ohy, ya' wanna see th' neww stuff?");
                          setState(() 
                          {
                            item.setReadState();
                          });
                          MainProgramState.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                            (item.senderName,item.subject,item.detail)));
                          WebDataMessageRead body = new WebDataMessageRead(StudentData.Instance,
                              item.personMessageId);
                          WebServices.setRead(Data.school, body);
                      });

                return new RefreshExecuter(icon: Icons.message,
                      asyncCallback: MainProgramState.of(context).messageList.incrementWeeks,
                      child: new TabBarView(children: <Widget>[
                          unread,
                          read,
                      ])
                );
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

class SortedMessages extends StatelessWidget
{

  final List<Message> _messages;
  final displayFunction _ontap;

  SortedMessages(List<Message> msg, displayFunction onTap) : this._messages = msg,
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