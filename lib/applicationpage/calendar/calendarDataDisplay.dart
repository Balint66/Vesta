import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/common/kamonjiDisplayer.dart';
import 'package:vesta/applicationpage/common/refreshExecuter.dart';
import 'package:vesta/applicationpage/calendar/calendarDailyView.dart';
import 'package:vesta/applicationpage/calendar/calendarListView.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'package:vesta/settings/pageSettings/data/calendarPageData.dart';
import 'package:vesta/web/bgFetchSateFullWidget.dart';

class LessonDisplayer extends BgFetchSateFullWidget
{

  LessonDisplayer({Key? key}) : super(key:key);

  @override
  BgFetchState<BgFetchSateFullWidget> createState()
  {
    return LessonDisplayerState();
  }

}

class LessonDisplayerState extends BgFetchState<LessonDisplayer>
{

  DateTime? nextEnd;

  static Future? _testingFuture;

  @override
  void initState()
  {
    super.initState();

    if(_testingFuture != null) {
      _testingFuture!.timeout(Duration(milliseconds: 1),onTimeout: ()=>null);
    }

    _testingFuture = Future.delayed(Duration(seconds: 1),() async
    {
      while(true)
      {

        await Future
          .doWhile(() async =>
            Future.delayed(Duration(seconds: 1), ()=>
            nextEnd == null || nextEnd!.isAfter(DateTime.now())));

        setState(() {});

        await Future.delayed(Duration(seconds: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context )
  {

    var list = AccountManager.currentAccount.calendarList;

    return RefreshExecuter(
        asyncCallback: AccountManager.currentAccount.calendarList.incrementDataIndex,
        child: StreamBuilder( stream: list.getData(),
        builder: (BuildContext ctx, AsyncSnapshot<BaseDataList<CalendarData?>> snap)
      {

        if(snap.hasError)
        {
          Vesta.logger.e('Garbage! Utterly garbage!', snap.error);
          return Text('${snap.error}');
        }
        else if(snap.hasData)
        {
          return _drawWithMode((SettingsManager.INSTANCE.settings.pageSettings['calendar'] as CalendarPageData).mode,
            snap.data!, context);
        }
            
        return FutureBuilder(future: Future.delayed(Duration(seconds: 1), ()=> true), builder: (ctx, shot)
        { 
          if(shot.hasData){
            return KamonjiDisplayer( RichText(textAlign: TextAlign.center, text: TextSpan(text:'You have got nothing new here pal.\n',
              style: Theme.of(context).textTheme.bodyText1,
              children:[
                TextSpan(text: '¯\\_(ツ)_/¯', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25))
              ])),
            );}
          return Center(child: CircularProgressIndicator());
        });

      }
    ));
    
    
  }

  Widget _drawWithMode(CalendarDisplayModes mode, BaseDataList<CalendarData?> response, BuildContext context)
  {
    switch(mode)
    {
      case CalendarDisplayModes.DAILYVIEW:
        return CalendarDailyView(response);
      case CalendarDisplayModes.LISTVIEW:
      default:
        return CalendarListView(response);
    }
  }

}

enum CalendarDisplayModes
{
  LISTVIEW,
  DAILYVIEW
}

extension DisplayNames on CalendarDisplayModes
{
  String get displayName {
    switch(this)
    {
      case CalendarDisplayModes.LISTVIEW:
        return 'List';
      case CalendarDisplayModes.DAILYVIEW:
        return 'daily';
      default:
        return 'NONE';
    }
  }
}
