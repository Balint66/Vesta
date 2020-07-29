import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
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

  static final PopupOptionData data = PopupOptionData(
    builder:(BuildContext ctx){ return null; }, selector: (int value){}
  );

  @override
  Widget build(BuildContext context)
  {
    var messages = MainProgram.of(context).messageList;
    var translator = AppTranslations.of(context);

    return Column(children:[
      Expanded(child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
                tabs: <Widget>
                [
                  Tab(text: translator.translate('messages_unread'),),
                  Tab(text: translator.translate('messages_read'),)
                ]
            ),
            primary: false,
          ),
          body: StreamBuilder(
              stream: messages.getData(),
              builder: (BuildContext context, AsyncSnapshot<MessageList> snap)
              {
                if(snap.hasData)
                {

                  Widget read =  SortedMessages((snap.data
                      .where((item)=>!item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time))),
                    (item){
                      MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                      (item.senderName,item.subject,item.detail)));
                  });

                  Widget unread =SortedMessages((snap.data
                      .where((item)=>item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time))),
                        (item) {
                          Vesta.logger.d("Ohy, ya' wanna see th' neww stuff?");
                          setState(() 
                          {
                            item.setReadState();
                          });
                          MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                            (item.senderName,item.subject,item.detail)));
                          var body = WebDataMessageRead(StudentData.Instance,
                              item.personMessageId);
                          WebServices.setRead(Data.school, body);
                      });

                return RefreshExecuter(icon: Icons.message,
                      asyncCallback: messages.incrementWeeks,
                      child: TabBarView(children: <Widget>[
                          unread,
                          read,
                      ])
                );
                }
                  return TabBarView(children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(child: CircularProgressIndicator())
                  ],);
                }
          )
        ),
    )),
      Center(child: Container(child: Text('${translator.translate("messages_max")}: ${messages.maxItemCount}'), padding: EdgeInsets.all(10),))
    ]);
  }

}

typedef displayFunction = void Function(Message item);

class SortedMessages extends StatelessWidget
{

  final List<Message> _messages;
  final displayFunction _ontap;

  SortedMessages(List<Message> msg, displayFunction onTap) : _messages = msg,
        _ontap = onTap,  super();

  @override
  Widget build(BuildContext context)
  {
    return ListView(
      children: List.of( _messages.map  ((item) => 
        ClickableCard(child: ListTile(title: Text(item.subject),
            subtitle: Text(item.senderName),
            onTap: () => _ontap(item),
            ),
          )
        )  
      ),
    );
  }

}