import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/semesters/PeriodDetailedDisplay.dart';
import 'package:vesta/datastorage/Lists/semestersDataList.dart';

class SemesterDisplayer extends StatefulWidget
{

  SemesterDisplayer({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() 
  {
    return new _SemesterDisplayerState();  
  }

}

class _SemesterDisplayerState extends State<SemesterDisplayer>
{

  static final PopupOptionData data = new PopupOptionData(
    builder:(BuildContext ctx){ return null; }, selector: (int value){}
  );

  @override
  Widget build(BuildContext context) 
  {

    var list = MainProgram.of(context).semesterList;

    return StreamBuilder(stream: list.getData(), builder: (BuildContext ctx, AsyncSnapshot<SemestersDataList> snap)
    {
      return FutureBuilder(future: list.getCurrentPeriod(), builder: (BuildContext futureContext, AsyncSnapshot<String> shot)
      {
        return snap.hasData && shot.hasData ? new Column(children: [
        new FutureBuilder(future: list.getPeriodTerms(), builder: ( BuildContext anotherContext, AsyncSnapshot<List<String>> data)
        {
          if(!data.hasData)
          {
            return new Center(child: new CircularProgressIndicator());
          }
          return PopupMenuButton(child: new ListTile(title: new Center(child: new Text(shot.data))), itemBuilder:(BuildContext cont)
            => new List.generate(data.data.length, (index) => new PopupMenuItem(value: index, child: new Text(data.data[index])),),
            onSelected: (index)=>list.setPeriodTermIndex(index),);
          
        }),
        new Expanded(child: new ListView(children: snap.data.map((element) => new ClickableCard(
          child: new ListTile(title: new Text("${element.PeriodName}"), 
                subtitle: new Text("${element.PeriodTypeName}\n${element.FromDate.toIso8601String()} - ${element.ToDate.toIso8601String()}"),onTap:()
                => MainProgram.of(context).parentNavigator.push(new MaterialPageRoute(builder: (context) => new PeriodDetailedDisplay(element),))),
          ) ).toList()))
      ])
      : new Center(child: new CircularProgressIndicator());
      });
    });
  }
  
}