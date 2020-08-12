import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/common/gradientDivider.dart';
import 'package:vesta/applicationpage/common/textDetailItem.dart';
import 'package:vesta/datastorage/periodData.dart';
import 'package:vesta/i18n/appTranslations.dart';

class PeriodDetailedDisplay extends StatelessWidget
{

  final PeriodData data;

  PeriodDetailedDisplay(PeriodData data) : data = data;

  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);

    return Scaffold(appBar: AppBar(title: Text( data.PeriodName)),
     body:  ListView.separated(itemBuilder: (BuildContext ctx, int index)
     {
       switch(index)
       {
         case 0: return TextDetailItem(translator.translate('period_name'), data.PeriodName);
         case 1: return TextDetailItem(translator.translate('period_type'), data.PeriodTypeName);
         case 2: return TextDetailItem(translator.translate('period_time'), '${data.FromDate.toString()} - ${data.ToDate.toString()}');
         case 3:
          var admins = data.OrgAdmins;
          if(admins.length > 100)
          {
            admins = admins.substring(0, 100) + '...';
          }
          return TextDetailItem(translator.translate('period_admin'), admins);
         case 4: return TextDetailItem(translator.translate('period_id'), data.TrainingtermIntervalId.toString());
         default:
          return Text('Unknown index!');
       }
     }, separatorBuilder: (BuildContext ctx, int index)
     {
       return GradientDivider();
     }, itemCount: 5));
  }
  

}