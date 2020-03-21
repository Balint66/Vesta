import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/lessons/lessonDetailedDisplay.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataCalendarResponse.dart';

//TODO: inspect this case further
// ignore: must_be_immutable
class LessonDisplayer extends InheritedWidget with BackgroundFetchingServiceMixin
{

  final Duration timespan;

  LessonDisplayer({Key key}) : this.timespan = new Duration(seconds: 30),
        super(key:key, child: new _LessonDisplayer())
  {
    FetchManager.register(this);
  }

  WebDataCalendarResponse _calendarData;
  Future<WebDataCalendarResponse> get calendarData async
  {

    await Future.doWhile(() async
    {

      await Future.delayed(new Duration(seconds: 1));

      return _calendarData == null && _calendarData.calendarData.length == null;
    });

    return _calendarData;

  }

  @override
  Future<void> onUpdate() async
  {

    WebDataCalendarResponse resp = await WebServices.getCalendarData(Data.school,
        StudentData.Instance);

    if(resp == null)
      return;

      _calendarData = resp;

  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)
  {
    return true;
  }

  static LessonDisplayer of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<LessonDisplayer>();
  }

}

class _LessonDisplayer extends BgFetchSateFullWidget
{


  _LessonDisplayer({Key key}) : super(key:key);

  @override
  BgFetchState<BgFetchSateFullWidget> createState()
  {
    return new LessonDisplayerState();
  }

}

class LessonDisplayerState extends BgFetchState<_LessonDisplayer>
{

  @override
  Widget build(BuildContext context )
  {

    return new FutureBuilder(future: LessonDisplayer.of(context).calendarData,
        builder: (BuildContext ctx, AsyncSnapshot<WebDataCalendarResponse> snap)
      {
        if(snap.hasError)
        {
          Vesta.logger.e(snap.error);
          return Text("${snap.error}");
        }
        else if(snap.hasData)
        {
          return drawWithMode(CalendarDisplayModes.LISTVIEW, snap.data, context);
        }


        return new Center(child: new CircularProgressIndicator());

      }
    );
  }

  Widget drawWithMode(CalendarDisplayModes mode, WebDataCalendarResponse response, BuildContext context)
  {
    switch(mode)
    {
      
      case CalendarDisplayModes.LISTVIEW:
      default:
        return ListView.builder(itemBuilder: (BuildContext ctx, int index)
        {
          if(index>= response.calendarData.length)
          {
            return null;
          }

          return new Card(child: new ListTile(
                title: new Text( response.calendarData[index].title),
                onTap: ()=> MainProgramState.of(context).parentNavigator.push(new MaterialPageRoute(
                    builder: (BuildContext context){
                      return new LessonDetailedDisplay(response.calendarData[index]);
                    })),),);
        });
    }
  }

}

enum CalendarDisplayModes
{
  LISTVIEW
}