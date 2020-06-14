import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
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

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(stream: MainProgramState.of(context).studentBook.getData(),builder:(BuildContext ctx, AsyncSnapshot<StudentBookDataList> snap)
    {

      if(snap.hasData)
        return new ListView(children: snap.data.expand((element) => [new Card(child: new ListTile(
          leading: new Icon(element.Completed ? Icons.check : Icons.close, color: element.Completed ? Colors.green : Colors.red),
          title: new Text(element.SubjectName), 
          subtitle: new Text(element.Values.replaceAll("<br/>", "\n"))))]).toList());

      return new Center(child: new CircularProgressIndicator());
    });
  }

}