import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/lessons/lessonDetailedDisplay.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';

class CalendarListView extends StatefulWidget
{

  final BaseDataList<CalendarData> data;

  CalendarListView(this.data, {Key? key}): super(key:key);

  @override
  State<StatefulWidget> createState() => CalendarListViewState();

}

class CalendarListViewState extends State<CalendarListView>
{
  @override
  Widget build(BuildContext context)
  {
    var response = BaseDataList(other: widget.data
        .where((element) => element.end.isAfter(DateTime.now()) ).toList());

    context.findAncestorStateOfType<LessonDisplayerState>()!.nextEnd = response[0].end;
    
    return ListView.builder(
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
  
}