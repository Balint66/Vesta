import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/calendar/calendarBody.dart';
import 'package:vesta/applicationpage/calendar/calendarDataDisplay.dart';
import 'package:vesta/applicationpage/common/kamonjiDisplayer.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';

class CalendarListView extends StatefulWidget
{

  final BaseDataList<CalendarData?> data;

  CalendarListView(this.data, {Key? key}): super(key:key);

  @override
  State<StatefulWidget> createState() => CalendarListViewState();

}

class CalendarListViewState extends State<CalendarListView>
{
  @override
  Widget build(BuildContext context)
  {

    if(widget.data.isEmpty)
    {
      return KamonjiDisplayer( RichText(textAlign: TextAlign.center, text: TextSpan(text:'You have got nothing new here pal.\n',
              style: Theme.of(context).textTheme.bodyText1,
              children:[
                TextSpan(text: '¯\\_(ツ)_/¯', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25))
              ]))
            );
      }

    var response = BaseDataList(other: widget.data
        .where((element) => element!.end.isAfter(DateTime.now()) ).toList());

    context.findAncestorStateOfType<LessonDisplayerState>()!.nextEnd = response[0]!.end;
    
    return ListView.builder(
      shrinkWrap: false,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: response.length,
      reverse: true,
      itemBuilder: (BuildContext ctx, int index)
      {
        return ClickableCard(
          child: CalendarBody(response[index]!),
        );
      }
    );
  }
  
}