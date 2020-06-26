import 'package:flutter/material.dart';
import 'package:vesta/datastorage/courseData.dart';

typedef CourseSetter = void Function(int id);

class CoursesDisplayer extends StatelessWidget
{

  final CourseSetter _setter;
  final List<CourseData> _datas;

  CoursesDisplayer(List<CourseData> data, CourseSetter setter) : this._setter = setter, this._datas = data, super();

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        appBar: new AppBar(title: new Text("Subject Details")),
        body: new ListView.builder(itemBuilder: (BuildContext context, int index)
    {

      if(index >= _datas.length)
        return new Text("Unkown Index value!");

      var item = _datas[index];

      return new Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: new FlatButton(child: new Column(children: 
        [
          new Text("Course code: ${item.CourseCode}"),
          new Text("Person/Waiting List/Limit: ${item.Letszamok}"),
          new Text("Time Table inf.: ${item.CourseTimeTableInfo}"),
          new Text("Tutor: ${item.CourseTutor}"),
          new Text("Rank point :P : ${item.RangsorPontszamok}")
        ]),
         onPressed: ()=> _setter(index))
       );

    }, itemCount: _datas.length,));
    
  }

}