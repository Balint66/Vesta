import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/lessons/lessonDetailedDisplay.dart';
import 'package:vesta/applicationpage/refreshExecuter.dart';
import 'package:vesta/datastorage/Lists/calendarDataList.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';

class LessonDisplayer extends BgFetchSateFullWidget
{

  LessonDisplayer({Key key}) : super(key:key);

  @override
  BgFetchState<BgFetchSateFullWidget> createState()
  {
    return LessonDisplayerState();
  }

}

class LessonDisplayerState extends BgFetchState<LessonDisplayer>
{

static final PopupOptionData data = PopupOptionData(
    builder:(BuildContext ctx){ return null; }, selector: (int value){}
  );

  DateTime _nextEnd;

  static Future _testingFuture;

  @override
  void initState()
  {
    super.initState();

    if(_testingFuture != null) {
      _testingFuture.timeout(Duration(milliseconds: 1),onTimeout: ()=>null);
    }

    _testingFuture = Future.delayed(Duration(seconds: 1),() async
    {
      while(true)
      {

        do
        {

          await Future.delayed(Duration(seconds: 1));

        }while(_nextEnd == null || _nextEnd.isAfter(DateTime.now()));

        setState(() {});

        await Future.delayed(Duration(seconds: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context )
  {

    var list = MainProgram.of(context).calendarList;

    return list.maxItemCount > 0 ?

      StreamBuilder( stream: list.getData(),
          builder: (BuildContext ctx, AsyncSnapshot<CalendarDataList> snap)
        {
          if(snap.hasError)
          {
            Vesta.logger.e(snap.error);
            return Text('${snap.error}');
          }
          else if(snap.hasData)
          {
            return _drawWithMode(CalendarDisplayModes.LISTVIEW, snap.data, context);
          }
            
              return Center(child: CircularProgressIndicator());

        }
      )
    :

      Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(text:'You have got nothing new here pal.\n',
              style: Theme.of(context).textTheme.bodyText1,
              children:[
                TextSpan(text: '¯\\_(ツ)_/¯', style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25))
              ]))
    );
    
  }

  Widget _drawWithMode(CalendarDisplayModes mode, CalendarDataList response, BuildContext context)
  {
    switch(mode)
    {
      
      case CalendarDisplayModes.LISTVIEW:
      default:
        return _drawList(response, context);
    }
  }

  Widget _drawList(CalendarDataList response, BuildContext context)
  {
    
    response = CalendarDataList(other: response
        .where((element) => element.end.isAfter(DateTime.now()) ).toList());

    _nextEnd = response[0].end;
    
    return RefreshExecuter(
        asyncCallback: MainProgram.of(context).calendarList.incrementWeeks,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: response.length,
            itemBuilder: (BuildContext ctx, int index)
            {
              return ClickableCard(child: ListTile(
                title: Text( response[index].title),
                  onTap: ()=> MainProgram.of(context).parentNavigator.push(MaterialPageRoute(
                  builder: (BuildContext context){
                return LessonDetailedDisplay(response[index]);
                })),
                ),
              );
            }
        )
    );


  }

}

enum CalendarDisplayModes
{
  LISTVIEW,
  DAILYVIEW
}
