import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/bgFetchSateFullWidget.dart';
import 'package:vesta/web/webdata/webDataCalendarResponse.dart';

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
with BackgroundFetchingServiceMixin
{


  WebDataCalendarResponse _calendarData;
   Future<WebDataCalendarResponse> get calendarData async
   {
     await Future.delayed(new Duration(seconds: 1), () async =>
      await Future.doWhile(() async 
      {
        
        await Future.delayed(new Duration(seconds: 1));
        
        return _calendarData == null;
      }));
      return _calendarData;
   }

  @override
  void initState()
  {
    super.initState();
    FetchManager.fetch();

  }

  @override
  Widget build(BuildContext context )
  {

    return new FutureBuilder(future: calendarData ,builder: (BuildContext ctx,
        AsyncSnapshot<WebDataCalendarResponse> snap)
    {
      if(snap.hasError)
      {
        Vesta.logger.e(snap.error);
        return Text("${snap.error}");
      }
      else if(snap.hasData)
      {
        return drawWithMode(CalendarDisplayModes.LISTVIEW, snap.data);
      }


      return new Center(child: new CircularProgressIndicator());
    });
  }

  Widget drawWithMode(CalendarDisplayModes mode, WebDataCalendarResponse response)
  {
    switch(mode)
    {
      
      case CalendarDisplayModes.LISTVIEW:
      default:
        return ListView.builder(itemBuilder: (BuildContext ctx, int index)
        {
          return index < response.calendarData.length
              ? new Card(child: new ListTile(
                title: new Text( response.calendarData[index].title),),)
          : null;
        });
    }
  }

  @override
  Future<void> onUpdate() async
  {

    if(!mounted)
      return;

    WebDataCalendarResponse resp = await WebServices.getCalendarData(Data.school,
    StudentData.Instance);

    if(resp == null)
      return;

    //double checking
    if(!mounted)
      return;

    setState(() {
      _calendarData = resp;
    });
  }

}

enum CalendarDisplayModes
{
  LISTVIEW
}