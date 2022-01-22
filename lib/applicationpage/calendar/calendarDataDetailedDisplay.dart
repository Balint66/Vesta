import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/common/genericDetailItem.dart';
import 'package:vesta/applicationpage/common/gradientDivider.dart';
import 'package:vesta/applicationpage/common/textDetailItem.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'calendarDetailed.i18n.dart';

class LessonDetailedDisplay extends StatelessWidget
{

  final CalendarData data;

  LessonDetailedDisplay(this.data);

  @override
  Widget build(BuildContext context) 
  {

    return Scaffold(
      body: ListView.separated(itemBuilder: (BuildContext context ,int index)
      {
        switch(index)
        {
          case 0: return TextDetailItem('lessons_title'.i18n, data.title);
          case 1: return TextDetailItem('lessons_desc'.i18n, data.description);
          case 2: return TextDetailItem('lessons_loc'.i18n, data.location);
          case 3: return TextDetailItem('lessons_start'.i18n, Vesta.dateFormatter.format(data.start));
          case 4: return TextDetailItem('lessons_end'.i18n, Vesta.dateFormatter.format(data.end) );
          case 5: return TextDetailItem('lessons_aday'.i18n, data.allDayLong ? '✔️' : '❌');
          case 6: return TextDetailItem('lessons_type'.i18n, data.type.toString().split('.').last);
          case 7: return TextDetailItem('lessons_id'.i18n, data.id);
          case 8 : return DetailItem('lessons_cl'.i18n,
              Container(decoration: BoxDecoration(color: data.eventColor), width: 10, height: 10));
          default: return Text('Unknown index!');
        }
      },
        separatorBuilder: (BuildContext context, int index)
        {
          return GradientDivider();
        }, 
        itemCount: 9),
    appBar: AppBar(title: Text(data.title), ), );
  }
  
}