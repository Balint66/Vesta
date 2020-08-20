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
with SingleTickerProviderStateMixin
{

  TabController _tabController;

  static final PopupOptionData data = PopupOptionData(
    builder:(BuildContext ctx){ return null; }, selector: (int value){}
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context)
  {
    var messages = MainProgram.of(context).messageList;
    var translator = AppTranslations.of(context);
    var unread = translator.translate('messages_unread');

    return StreamBuilder(
              stream: messages.getData(),
              builder: (BuildContext context, AsyncSnapshot<MessageList> snap)
              {

                var ls = <Widget>[];
                var unreadnum = 0;

                if(snap.hasData)
                {

                  var readls = (snap.data
                      .where((item)=>!item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time)));

                  var unreadls = (snap.data
                      .where((item)=>item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time)));

                  unreadnum = unreadls.length;

                  if(unreadls.isNotEmpty){
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {_tabController.animateTo(0);});
                  }

                  Widget read =  SortedMessages(readls,
                    (item){
                      MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>MessageDisplay
                      (item.senderName,item.subject,item.detail)));
                  });

                  Widget unread =SortedMessages(unreadls,
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
                  if(unreadls.isNotEmpty){
                    ls.add(unread);
                  } 
                  else{
                    ls.add(Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(text:'You don\'t have any new message!!\n',
                    style: Theme.of(context).textTheme.bodyText1,
                    children:[
                      TextSpan(text: '( ✧Д✧) YES!!', style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25))
                    ]))));
                  }
                  ls.add(read);  

                }
                else{
                  ls.add(Center(child: CircularProgressIndicator()));
                  ls.add(Center(child: CircularProgressIndicator()));
                }

                if(unreadnum > 0){
                  unread = unread + ' ($unreadnum)';
                }

                return Scaffold(
              bottomNavigationBar: BottomAppBar (
                child: TabBar(
                    controller: _tabController,
                    tabs: <Widget>
                    [
                      Tab(text: unread,),
                      Tab(text: translator.translate('messages_read'),)
                    ]
                ),
                color: Theme.of(context).primaryColor,
              ),
              body: RefreshExecuter(icon: Icons.message,
                          asyncCallback: messages.incrementWeeks,
                          child: TabBarView(children: ls, controller: _tabController,)

                )
              );

          }
        );

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