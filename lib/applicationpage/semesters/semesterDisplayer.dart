import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
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
  @override
  Widget build(BuildContext context) 
  {

    var list = MainProgramState.of(context).semesterList;

    return StreamBuilder(stream: list.getData(), builder: (BuildContext ctx, AsyncSnapshot<SemestersDataList> snap)
    {
      return snap.hasData ? new Column(children: [
        new PopupMenuButton(child: new ListTile(title: new Center(child: new Text(list.getCurrentPeriod()))), itemBuilder:(BuildContext cont)
            => new List.generate(list.getPeriodTerms().length, (index) => new PopupMenuItem(value: index, child: new Text(list.getPeriodTerms()[index])),),
            onSelected: (index)=>list.setPeriodTermIndex(index),),
        new Expanded(child: new ListView(children: snap.data.map((element) => new Card(child: new ListTile(title: new Text("${element.PeriodName}"), 
                subtitle: new Text("${element.PeriodTypeName}\n${element.FromDate.toIso8601String()} - ${element.ToDate.toIso8601String()}"),onTap:()
                => MainProgramState.of(context).parentNavigator.push(new MaterialPageRoute(builder: (context) => new PeriodDetailedDisplay(element),))),)).toList()))
      ])
      : new Center(child: new CircularProgressIndicator());
    });
  }
  
}