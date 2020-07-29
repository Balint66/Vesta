import 'package:flutter/material.dart';
import 'package:vesta/datastorage/courseData.dart';

typedef CourseSetter = void Function(int id);

class CoursesDisplayer extends StatelessWidget
{

  final CourseSetter _setter;
  final List<CourseData> _datas;

  CoursesDisplayer(List<CourseData> data, CourseSetter setter) : _setter = setter, _datas = data, super();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(title: Text('Subject Details')),
        body: ListView.builder(itemBuilder: (BuildContext context, int index)
    {

      if(index == 0) {
        return Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FlatButton(child: Text('None'),
         onPressed: ()=> _setter(-1))
       );
      }

      if(index - 1 >= _datas.length) {
        return Text('Unkown Index value!');
      }

      var item = _datas[index-1];

      return Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FlatButton(child: Column(children: 
        [
          Text('Course code: ${item.CourseCode}'),
          Text('Person/Waiting List/Limit: ${item.Letszamok}'),
          Text('Time Table inf.: ${item.CourseTimeTableInfo}'),
          Text('Tutor: ${item.CourseTutor}'),
          Text('Rank point :P : ${item.RangsorPontszamok}')
        ]),
         onPressed: ()=> _setter(index-1))
       );

    }, itemCount: _datas.length + 1,));
    
  }

}