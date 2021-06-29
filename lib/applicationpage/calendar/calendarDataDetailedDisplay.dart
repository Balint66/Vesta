import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/common/genericDetailItem.dart';
import 'package:vesta/applicationpage/common/gradientDivider.dart';
import 'package:vesta/applicationpage/common/textDetailItem.dart';
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

    return Scaffold(
      body: ListView.separated(itemBuilder: (BuildContext context ,int index)
      {
        switch(index)
        {
          case 0: return TextDetailItem(translator.translate('lessons_title'), data.title);
          case 1: return TextDetailItem(translator.translate('lessons_desc'), data.description);
          case 2: return TextDetailItem(translator.translate('lessons_loc'), data.location);
          case 3: return TextDetailItem(translator.translate('lessons_start'), Vesta.dateFormatter.format(data.start));
          case 4: return TextDetailItem(translator.translate('lessons_end'), Vesta.dateFormatter.format(data.end) );
          case 5: return TextDetailItem(translator.translate('lessons_aday'), data.allDayLong ? '✔️' : '❌');
          case 6: return TextDetailItem(translator.translate('lessons_type'), data.type.toString().split('.').last);
          case 7: return TextDetailItem(translator.translate('lessons_id'), data.id);
          case 8 : return DetailItem(translator.translate('lessons_cl'),
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