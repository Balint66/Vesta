import 'package:flutter/material.dart';
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
         case 0: return Text("${translator.translate("period_name")}: ${data.PeriodName}");
         case 1: return Text("${translator.translate("period_type")}: ${data.PeriodTypeName}");
         case 2: return Text("${translator.translate("period_time")}: ${data.FromDate.toString()} - ${data.ToDate.toString()}");
         case 3: return Text("${translator.translate("period_admin")}: ${data.OrgAdmins}");
         case 4: return Text("${translator.translate("period_id")}: ${data.TrainingtermIntervalId}");
         default:
          return Text('Unknown index!');
       }
     }, separatorBuilder: (BuildContext ctx, int index)
     {

      final divData = DividerTheme.of(context);

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
     }, itemCount: 5));
  }
  

}