import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/calendarData.dart';

class LessonDetailedDisplay extends StatelessWidget
{

  final CalendarData data;

  LessonDetailedDisplay(this.data);

  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold( body: new  ListView.separated(itemBuilder: (BuildContext context ,int index)
    {
      switch(index)
      {
        case 0: return new Text("Tile:\n" + data.title);
        case 1: return new Text("Description:\n" + data.description);
        case 2: return new Text("Location:\n" + data.location);
        case 3: return new Text("Starting date:\n" + data.start.toIso8601String());
        case 4: return new Text("Ending date:\n" + data.end.toIso8601String());
        case 5: return new Text("All day long:\n" + data.allDayLong.toString());
        case 6: return new Text("Type:\n" + data.type);
        case 7: return new Text("ID:\n" + data.id);
        case 8 : return new Row(children: <Widget>[new Text("Color:"),
            new Container(decoration: new BoxDecoration(color: data.eventColor),)],);
        default: return new Text("Unknown index!");
      }
    }, separatorBuilder: (BuildContext context, int index)
    {

      DividerThemeData divData = DividerTheme.of(context);

      final double thickness = divData.thickness ?? 0.5;
      final double indent = divData.indent ?? 0.0;
      final double endIndent = divData.endIndent ?? 0.0;

        return new Center( child: new  Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).backgroundColor],
                begin: Alignment.centerLeft, end: Alignment.centerRight
            ),
            border: Border(
              bottom: BorderSide(color: Theme.of(context).primaryColor)
            )
          ),
          height: thickness,
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
        ));
    }, itemCount: 9),
    appBar: new AppBar(),);
  }
  
}