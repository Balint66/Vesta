import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/refreshExecuter.dart';
import 'package:vesta/applicationpage/subjects/subjectDetailedDisplay.dart';
import 'package:vesta/datastorage/Lists/subjectDataList.dart';

class SubjectDisplayer extends StatefulWidget
{

  SubjectDisplayer({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState()
  {
    return _SubjectDisplayerState();  
  }

}

class _SubjectDisplayerState extends State<SubjectDisplayer>
{


  @override
  Widget build(BuildContext context)
  {

    return StreamBuilder(stream: MainProgram.of(context).subject.getData(), builder: (BuildContext ctx, AsyncSnapshot<SubjectDataList> snap)
      {
        if( !snap.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        snap.data.sort((e,k)=>e.SubjectName.compareTo(k.SubjectName));

        return RefreshExecuter(
          child: ListView(children: snap.data.map((element)
        {
          return ClickableCard(
            child: ListTile(leading: element.IsOnSubject ? Icon(Icons.content_copy, color: Colors.blue) 
            : element.Completed ? Icon(Icons.check, color: Colors.green) : Icon(Icons.toc, color: Colors.grey),
            title: Text(element.SubjectName), subtitle: Text('${element.SubjectCode}\n${element.SubjectRequirement}'),
            onTap: () {
              MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>SubjectDetailedDisplay(element)));
            },)
            );
        } ).toList(),),
        asyncCallback: MainProgram.of(context).subject.incrementWeeks,
        );
        
      }
    );  
  }
  
}