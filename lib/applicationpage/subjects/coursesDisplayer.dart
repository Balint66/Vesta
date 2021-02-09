import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/i18n/appTranslations.dart';

typedef CourseSetter = void Function(int id);

class CoursesDisplayer extends StatelessWidget
{

  final CourseSetter _setter;
  final List<CourseData> _datas;

  CoursesDisplayer(List<CourseData> data, CourseSetter setter) : _setter = setter, _datas = data, super();

  @override
  Widget build(BuildContext context) {
    
    var translator = AppTranslations.of(context);

    return Scaffold(
        appBar: AppBar(title: Text('Subject Details')),
        body: ListView.builder(itemBuilder: (BuildContext context, int index)
    {

      if(index == 0) {
        return Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextButton(child: Text('None'),
         onPressed: ()=> _setter(-1))
       );
      }

      if(index - 1 >= _datas.length) {
        return Text('Unkown Index value!');
      }

      var item = _datas[index-1];

      return Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ClickableCard(child: ListTile(title: Column(children: 
        [
          Text('${translator.translate("course_code")}: ${item.CourseCode}'),
          Text('${translator.translate("course_numbers")}: ${item.Letszamok}'),
          Text('${translator.translate("course_timetable")}: ${item.CourseTimeTableInfo}'),
          Text('${translator.translate("course_tutor")}: ${item.CourseTutor}'),
          Text('${translator.translate("course_ranks")}: ${item.RangsorPontszamok}')
        ]),
         onTap: ()=> _setter(index-1))
       ));

    }, itemCount: _datas.length + 1,));
    
  }

}