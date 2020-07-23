import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/datastorage/Lists/studentBookDataList.dart';

class StudentBookDisplay extends StatefulWidget
{

  StudentBookDisplay({Key key}) : super(key:key);

  @override
  State<StudentBookDisplay> createState()
  {
    return new _StudentBookDisplayState();
  }

}

class _StudentBookDisplayState extends State<StudentBookDisplay>
{

  static final PopupOptionData data = new PopupOptionData(
    builder:(BuildContext ctx){ return null; }, selector: (int value){}
  );

  @override
  Widget build(BuildContext context)
  {
    return new StreamBuilder(stream: MainProgram.of(context).studentBook.getData(),builder:(BuildContext ctx, AsyncSnapshot<StudentBookDataList> snap)
    {

      if(snap.hasData)
      {

        var regex = new RegExp(r"\(\d\)", unicode: true);

        List<int> grades = snap.data.map((e)=> int.parse(
          ((){
            var hasMatch = regex.hasMatch(e.Values);
            if(!hasMatch)
            {
              return "0";
            }
            else
            {
              var match = regex.allMatches(e.Values);
              return match.last.group(0)[1];
            }
            }).call()))
          .toList();
        List<int> creditsIn = snap.data.map((e)=>e.Credit).toList();

        double credIndex = snap.data.where((e)=> e.Values != null && e.Values.isNotEmpty).map((e)=> int.parse((()
        {
          var hasMatch = regex.hasMatch(e.Values);
            if(!hasMatch)
            {
              return "0";
            }
            else
            {
              var match = regex.allMatches(e.Values);
              return match.last.group(0)[1];
            }
        }).call()).toDouble() * e.Credit).fold(0, (prev, element) => prev + element) / 30.0;

        double average = grades.fold<int>(0, (prev, element) => prev + element) / grades.where((element) => element != 0).length.toDouble();

        double credPercent = (snap.data.where((e)=> e.Values != null && e.Values.isNotEmpty).map((e) =>e.Credit).fold(0, (prev, e) => prev + e) as int).toDouble() / 
            (snap.data.map((e)=> e.Credit).fold(0,(prev, e) => prev + e)).toDouble();

        return new Column(children: [
          new Column(children:[new Text("Average: $average"), new Text("Credit Index: $credIndex"), new Text("KKI: ${ credIndex * credPercent}")],
           mainAxisAlignment: MainAxisAlignment.center),
          new Expanded( child: new ListView(children: snap.data.expand((element) => [new Card(child: new ListTile(
          leading: new Icon(element.Completed ? Icons.check : Icons.close, color: element.Completed ? Colors.green : Colors.red),
          title: new Text(element.SubjectName), 
          subtitle: new Text(element.Values.replaceAll("<br/>", "\n"))))]).toList()))]);
          }

      return new Center(child: new CircularProgressIndicator());
    });
  }

}