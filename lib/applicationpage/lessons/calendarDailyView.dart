import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/kamonjiDisplayer.dart';
import 'package:vesta/applicationpage/lessons/lessonDetailedDisplay.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:vesta/utils/DateUtil.dart';
import 'package:intl/intl.dart';

class CalendarDailyView extends StatefulWidget
{
  final BaseDataList<CalendarData> data;

  CalendarDailyView(this.data, {Key? key}): super(key:key);

  @override
  State<StatefulWidget> createState() => CalendarDailyViewState();

}

class CalendarDailyViewState extends State<CalendarDailyView>
{

  DateTime day = DateTime.fromMillisecondsSinceEpoch(DateUtil.epochFlooredToDays(DateTime.now()));

  @override
  Widget build(BuildContext context) 
  {

    var response = BaseDataList(other: widget.data
        .where((element) => element.end.isAfter(day)
          && element.end.isBefore(day.add(Duration(days:1))) ).toList());

    late Widget body;

    if(response.isEmpty)
    {
      context.findAncestorStateOfType<LessonDisplayerState>()!.nextEnd = null;
      body=KamonjiDisplayer( RichText(textAlign: TextAlign.center,
        text: TextSpan(text:'You Don\'t have anything today.\n',
          style: Theme.of(context).textTheme.bodyText1,
          children:[
              TextSpan(text: '¯\\_(ツ)_/¯', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25))
            ],
          ),
        ),
      );  
    }
    else
    {
      context.findAncestorStateOfType<LessonDisplayerState>()!.nextEnd = response[0].end;
      body = ListView.builder(
        shrinkWrap: false,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: response.length,
        itemBuilder: (BuildContext ctx, int index)
        {
          return ClickableCard(
            secondColor: response[index].eventColor,child: ListTile(
            title: Text( response[index].title),
              onTap: ()=> MainProgram.of(context).parentNavigator.push(MaterialPageRoute(
              builder: (BuildContext context){
            return LessonDetailedDisplay(response[index]);
            })),
            ),
          );
        }
      );
    }
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child:Container(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(onTap: ()=>
              setState(()
              {
                day = day.subtract(Duration(days:1));
                MainProgram.of(context).calendarList.setDataIndex((DateTime.now().difference(day).inDays/7).floor());
              }),
              child:Icon(FeatherIcons.arrowLeft, color: Theme.of(context).accentIconTheme.color)
            ,),
            GestureDetector(onTap: ()=>
            setState((){
              day = DateTime.fromMillisecondsSinceEpoch(DateUtil.epochFlooredToDays(DateTime.now()));
              MainProgram.of(context).calendarList.setDataIndex(1);
            }),
              child:Text(DateFormat('yy. MM. dd.').format(day), style: Theme.of(context).primaryTextTheme.button)
            ),
            GestureDetector(onTap: ()=>
            setState((){
              day = day.add(Duration(days:1));
              MainProgram.of(context).calendarList.setDataIndex((DateTime.now().difference(day).inDays/7).floor());
            }),
            child: Icon(FeatherIcons.arrowRight, color: Theme.of(context).accentIconTheme.color),
            ),
          ],),)),
      body: body);
  }

}