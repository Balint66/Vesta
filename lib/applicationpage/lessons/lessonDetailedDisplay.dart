import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:vesta/i18n/appTranslations.dart';

class LessonDetailedDisplay extends StatelessWidget
{

  final CalendarData data;

  LessonDetailedDisplay(this.data);

  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);

    return Scaffold( body: ListView.separated(itemBuilder: (BuildContext context ,int index)
    {
      switch(index)
      {
        case 0: return Text('${translator.translate("lessons_title")}:\n ${data.title}');
        case 1: return Text("${translator.translate("lessons_desc")}:\n" + data.description);
        case 2: return Text("${translator.translate("lessons_loc")}:\n" + data.location);
        case 3: return Text("${translator.translate("lessons_start")}:\n" + data.start.toString() );
        case 4: return Text("${translator.translate("lessons_end")}:\n" + data.end.toString() );
        case 5: return Text("${translator.translate("lessons_aday")}:\n" + data.allDayLong.toString());
        case 6: return Text("${translator.translate("lessons_type")}:\n" + data.type);
        case 7: return Text("${translator.translate("lessons_id")}:\n" + data.id);
        case 8 : return Row(children: <Widget>[Text("${translator.translate("lessons_col")}:"),
            Container(decoration: BoxDecoration(color: data.eventColor), width: 10, height: 10)],);
        default: return Text('Unknown index!');
      }
    }, separatorBuilder: (BuildContext context, int index)
    {

      var divData = DividerTheme.of(context);

      final thickness = divData.thickness ?? 0.5;
      final indent = divData.indent ?? 0.0;
      final endIndent = divData.endIndent ?? 0.0;

        return Center( child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
    appBar: AppBar(),);
  }
  
}