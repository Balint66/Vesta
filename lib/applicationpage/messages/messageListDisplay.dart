import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/applicationpage/messages/messageDisplay.dart';
import 'package:vesta/datastorage/messagesList.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataMessages.dart';

//TODO: inspect this case further
// ignore: must_be_immutable
class MessageListDisplay extends InheritedWidget with BackgroundFetchingServiceMixin
{

  final Duration timespan;

  MessageListDisplay({Key key}) : this.timespan = new Duration(hours: 1),
        super(key:key, child: new _MessageListDisplay())
  {
    FetchManager.register(this);
  }

  final MessageList _messages = new List<Message>();

  Future<MessageList> get messages async
  {
    await Future.doWhile(() async
    {
      await Future.delayed(new Duration(seconds: 1));
      return _messages == null;
    });

    return _messages;

  }

  @override
  Future<void> onUpdate()  async
  {
    WebDataMessages resp = await WebServices
        .getMessages(Data.school, StudentData.Instance);

    if(resp == null)
      return;

      resp.MessagesList.forEach((Message message)
      {
        if(!_messages.contains(message))
          _messages.add(message);
      }
      );

  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)
  {
    return true;
  }

  static MessageListDisplay of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<MessageListDisplay>();
  }

}

class _MessageListDisplay extends BgFetchSateFullWidget
{

  _MessageListDisplay({Key key}):super(key:key);

  @override
  MessageListDisplayState createState() {
    return MessageListDisplayState();
  }

}

class MessageListDisplayState extends BgFetchState<_MessageListDisplay>
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
                  Tab(text: "Olvasatlan",),
                  Tab(text: "Olvasott",)
                ]
            ),
            primary: false,
          ),
          body: FutureBuilder( future: MessageListDisplay.of(context).messages,
              builder: (BuildContext context, AsyncSnapshot<List<Message>> snap)
              {
                if(snap.hasData)
                {

                  Widget read = new SortedMesages((MessageListDisplay.of(context)
                      ._messages.where((item)=>!item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time))),
                    (item){
                      MainProgramState.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                      (item.senderName,item.subject,item.detail)));
                  });

                  Widget unread = new SortedMesages((MessageListDisplay.of(context)
                      ._messages.where((item)=>item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time))),
                        (item) {
                        setState(() {
                          item.setReadState();
                        });
                        MainProgramState.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                          (item.senderName,item.subject,item.detail)));
                        WebServices.setRead(Data.school, StudentData.Instance, item.personMessageId);
                        this.reassemble();
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