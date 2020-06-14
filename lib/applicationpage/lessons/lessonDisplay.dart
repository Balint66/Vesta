import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
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
    return new LessonDisplayerState();
  }

}

class LessonDisplayerState extends BgFetchState<LessonDisplayer>
{

  DateTime _nextEnd;

  static Future _testingFuture;

  @override
  void initState()
  {
    super.initState();

    if(_testingFuture != null)
      _testingFuture.timeout(new Duration(milliseconds: 1),onTimeout: ()=>null);

    _testingFuture = Future.delayed(new Duration(seconds: 1),() async
    {
      while(true)
      {

        do
        {

          await Future.delayed(new Duration(seconds: 1));

        }while(_nextEnd == null || _nextEnd.isAfter(DateTime.now()));

        setState(() {});

        await Future.delayed(new Duration(seconds: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context )
  {

    return new StreamBuilder( stream: MainProgramState.of(context).calendarList.getData(),
        builder: (BuildContext ctx, AsyncSnapshot<CalendarDataList> snap)
      {
        if(snap.hasError)
        {
          Vesta.logger.e(snap.error);
          return Text("${snap.error}");
        }
        else if(snap.hasData)
        {
          return _drawWithMode(CalendarDisplayModes.LISTVIEW, snap.data, context);
        }


        return new FutureBuilder(builder: (BuildContext cont, AsyncSnapshot<bool> shot)
        {  
          
            return Center(child: shot.hasData 
            ? new RichText(textAlign: TextAlign.center, text: TextSpan(text:"You have got nothing new here pal.\n", 
              children:[
                new TextSpan(text: "¯\\_(ツ)_/¯", style: new TextStyle(fontSize: 25, ))
              ])) 
            : new CircularProgressIndicator());
        },
        future: Future.delayed(new Duration(seconds: 5), () async => true)
        );

      }
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
    
    response = new CalendarDataList(other: response
        .where((element) => element.end.isAfter(DateTime.now()) ).toList());

    _nextEnd = response[0].end;
    
    return new RefreshExecuter(
        asyncCallback: MainProgramState.of(context).calendarList.incrementWeeks,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: response.length,
            itemBuilder: (BuildContext ctx, int index)
            {
              return new Card(child: new ListTile(
                title: new Text( response[index].title),
                  onTap: ()=> MainProgramState.of(context).parentNavigator.push(new MaterialPageRoute(
                  builder: (BuildContext context){
                return new LessonDetailedDisplay(response[index]);
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
  LISTVIEW
}
