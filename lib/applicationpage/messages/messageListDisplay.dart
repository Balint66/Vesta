import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/kamonjiDisplayer.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/common/refreshExecuter.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/applicationpage/messages/messageDisplay.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataMessageRead.dart';

class MessageListDisplay extends BgFetchSateFullWidget
{

  MessageListDisplay({Key? key}):super(key:key);

  @override
  MessageListDisplayState createState() {
    return MessageListDisplayState();
  }

}

class MessageListDisplayState extends BgFetchState<MessageListDisplay>
with SingleTickerProviderStateMixin
{

  TabController? _tabController;

  static final PopupOptionData data = PopupOptionData(
    builder:(BuildContext ctx){ return []; }, selector: (int value){}
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context)
  {
    final messages = MainProgram.of(context).messageList;
    final translator = AppTranslations.of(context);

    return StreamBuilder(
              stream: messages.getData(),
              builder: (BuildContext context, AsyncSnapshot<BaseDataList<Message>> snap)
              {

                var unread = translator.translate('messages_unread');

                var ls = <Widget>[];
                var unreadnum = 0;

                if(snap.hasData)
                {

                  var readls = (snap.data!
                      .where((item)=>!item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time)));

                  var unreadls = (snap.data!
                      .where((item)=>item.isNew).toList()
                      ..sort((Message a, Message b)=>-1*a.time.compareTo(b.time)));

                  unreadnum = unreadls.length;

                  if(unreadls.isNotEmpty){
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {_tabController!.animateTo(0);});
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
                          var body = WebDataMessageRead(AccountManager.currentAcount,
                              item.personMessageId);
                          WebServices.setRead(AccountManager.currentAcount.school, body);
                      },
                      onLongPress: (item)
                      {
                        setState(() 
                        {
                          item.setReadState();
                        });
                        var body = WebDataMessageRead(AccountManager.currentAcount,
                              item.personMessageId);
                          WebServices.setRead(AccountManager.currentAcount.school, body);
                      },);
                  if(unreadls.isNotEmpty){
                    ls.add(unread);
                  } 
                  else{
                    ls.add(KamonjiDisplayer(RichText(textAlign: TextAlign.center, text: TextSpan(text:translator.translate('messages_unread_kamonji'),
                        style: Theme.of(context).textTheme.bodyText1,
                        children:[
                          TextSpan(text: '( ✧Д✧) YASSS!!', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25))
                    ])
                        ),
                      ),
                    );
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
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                      controller: _tabController,
                      tabs: <Widget>
                      [
                        Tab(text: unread,),
                        Tab(text: translator.translate('messages_read'),)
                      ]
                  ),
                ),
                body: RefreshExecuter(icon: Icons.message,
                            asyncCallback: messages.incrementDataIndex,
                            child: TabBarView(controller: _tabController, children: ls, )

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
  final displayFunction? _onLongPress;

  SortedMessages(List<Message> msg, displayFunction onTap, {displayFunction? onLongPress}) : _messages = msg,
        _ontap = onTap, _onLongPress = onLongPress, super();

  @override
  Widget build(BuildContext context)
  {
    return ListView(
      children: List.of( _messages.map  ((item) => 
        ClickableCard(child: ListTile(title: Text(item.subject),
            subtitle: Text(item.senderName),
            onTap: () => _ontap(item),
            onLongPress: () => _onLongPress?.call(item),
            ),
          )
        )  
      ),
    );
  }

}