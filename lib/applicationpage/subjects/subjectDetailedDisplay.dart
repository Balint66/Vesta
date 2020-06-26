import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/subjects/coursesDisplayer.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/datastorage/subjectData.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataCourseRequest.dart';
import 'package:vesta/web/webdata/webDataCourseResponse.dart';
import 'package:vesta/web/webdata/webDataSubjectSignup.dart';

class SubjectDetailedDisplay extends StatelessWidget
{

  final SubjectData data;

  SubjectDetailedDisplay(SubjectData data) : this.data = data;

  @override
  Widget build(BuildContext context) 
  {

    var f = WebServices.getCourses(Data.school, new WebDataCourseRequest(StudentData.Instance, Id: data.SubjectId, CurriculumID: data.CurriculumTemplateID, TermID: data.TermID));

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
            //Here was the moment I decided not to make another statful widget just for displaying the buttons.
            //It was a really fun time and I like the solution I came up with.
            //(Future me pls don't kill me)
            new FutureBuilder(future: f, builder: (BuildContext ctx, AsyncSnapshot<WebDataCourseResponse> snap)
            {
              if(!snap.hasData)
                return new CircularProgressIndicator();

              Map<String, List<CourseData>> coursesByType = groupBy(snap.data.CourseList, (CourseData obj)=>obj.CourseType_DNAME);
              List<int> courses = List.generate(coursesByType.length, (index) => -1);
              var entries = coursesByType.entries.toList();

              return new Column(children:[ new StatefulBuilder(builder:(BuildContext context, StateSetter setState)
              {
                
                return new Column(children: List.generate(courses.length, (index)
                {

                  return new Container(
                    child: new Container(
                      child: new ListTile(
                        title: new Center(child: new Text(entries[index].key)),
                        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new CoursesDisplayer(entries[index].value,(ind)
                        {
                            setState((){
                              courses[index] = ind;
                            });
                            Navigator.pop(context);
                        }),)),
                        subtitle: new Center(child: new Text("${courses[index] < 0 ? 'None' : entries[index].value[courses[index]].CourseCode}"))),
                    color: Theme.of(context).primaryColor, ), padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10));

                }));

              }),
            new StatefulBuilder(builder: ( BuildContext context, StateSetter setState)
            {
              return new Container(
                    child: new Container(
                      child: new ListTile(
                        title: new Center(child: new Text(data.IsOnSubject ? "Leave subject" : "Signup for subject")),
                        onTap: () async
                        {
                          try
                          {
                            await WebServices.saveSubject(Data.school, new WebDataSubjectSignupRequest(StudentData.Instance, TermID: data.TermID,
                            SubjectID: data.SubjectId, CurriculumID: data.CurriculumTemplateID, IsOnSubject: data.IsOnSubject,
                            SubjectSignin: !data.IsOnSubject, CurriculumTemplatelineID: data.CurriculumTemplatelineID,
                            AllType: entries.map((e) => e.value[0].CourseType).toList(), CourseIDs: (()
                            {
                              List<int> list = List.generate(courses.length, (index) => 0);

                              for(int i = 0; i < courses.length; i++)
                              {
                                if(courses[i] == -1)
                                  continue;

                                list[i] = entries[i].value[courses[i]].Id;
                                
                              }

                              return list;
                            }).call()));
                          }
                          catch(e)
                          {
                            Vesta.showSnackbar(new Text("$e"));
                          }
                        }),
                    color: Theme.of(context).primaryColor, ), padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10));

            })]);
            },)
      ])));  
  }

}