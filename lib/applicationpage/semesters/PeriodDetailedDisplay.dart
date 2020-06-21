import 'package:flutter/material.dart';
import 'package:vesta/datastorage/periodData.dart';

class PeriodDetailedDisplay extends StatelessWidget
{

  final PeriodData data;

  PeriodDetailedDisplay(PeriodData data) : this.data = data;

  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold(appBar: new AppBar(title: new Text( data.PeriodName)),
     body:  new ListView.separated(itemBuilder: (BuildContext ctx, int index)
     {
       switch(index)
       {
         case 0: return new Text("Period Name: ${data.PeriodName}");
         case 1: return new Text("Period Type: ${data.PeriodTypeName}");
         case 2: return new Text("Period Time: ${data.FromDate.toIso8601String()} - ${data.ToDate.toIso8601String()}");
         case 3: return new Text("Administrators: ${data.OrgAdmins}");
         case 4: return new Text("ID: ${data.TrainingtermIntervalId}");
         default:
          return new Text("Unknown index!");
       }
     }, separatorBuilder: (BuildContext ctx, int index)
     {

      final DividerThemeData divData = DividerTheme.of(context);

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
     }, itemCount: 5));
  }
  

}