import 'package:flutter/material.dart';
import 'package:vesta/datastorage/subjectData.dart';

class SubjectDetailedDisplay extends StatelessWidget
{

  final SubjectData data;

  SubjectDetailedDisplay(SubjectData data) : this.data = data;

  @override
  Widget build(BuildContext context) 
  {
      return new Scaffold(
        appBar: new AppBar(title: new Text("Subject Details")),
        body: new Center(child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            new Text("Subject name", style: new TextStyle(color: Colors.grey, fontSize: 9)),
            new Text(data.SubjectName),
            new Text("Subject Code", style: new TextStyle(color: Colors.grey, fontSize: 9)),
            new Text(data.SubjectCode),
            new Text("Subject Requirements", style: new TextStyle(color: Colors.grey, fontSize: 9)),
            new Text(data.SubjectRequirement),
            new Text("Subject Type", style: new TextStyle(color: Colors.grey, fontSize: 9)),
            new Text(data.SubjectSignupType),
            new Text("Credits", style: new TextStyle(color: Colors.grey, fontSize: 9)),
            new Text("${data.Credit}"),
      ])));  
  }

}