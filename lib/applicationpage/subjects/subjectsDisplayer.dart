import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/refreshExecuter.dart';
import 'package:vesta/applicationpage/subjects/subjectDetailedDisplay.dart';
import 'package:vesta/datastorage/Lists/subjectDataList.dart';

class SubjectDisplayer extends StatefulWidget 
{

  SubjectDisplayer({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState()
  {
    return new _SubjectDisplayerState();  
  }

}

class _SubjectDisplayerState extends State<SubjectDisplayer>
{
  @override
  Widget build(BuildContext context)
  {
    return new StreamBuilder(stream: MainProgramState.of(context).subject.getData(), builder: (BuildContext ctx, AsyncSnapshot<SubjectDataList> snap)
    {
      if( !snap.hasData)
        return new Center(child: new CircularProgressIndicator());

      snap.data.sort((e,k)=>e.SubjectName.compareTo(k.SubjectName));

      return new RefreshExecuter(
        child: new ListView(children: snap.data.map((element)
      {
        return new Card(child: new ListTile(leading: element.IsOnSubject ? new Icon(Icons.content_copy, color: Colors.blue) 
          : element.Completed ? new Icon(Icons.check, color: Colors.green) : new Icon(Icons.toc, color: Colors.grey),
          title: new Text(element.SubjectName), subtitle: new Text("${element.SubjectCode}\n${element.SubjectRequirement}"),
          onTap: () {
            MainProgramState.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>SubjectDetailedDisplay(element)));
          },));
      } ).toList(),),
      asyncCallback: MainProgramState.of(context).subject.incrementWeeks,
      );
      
    });  
  }
  
}