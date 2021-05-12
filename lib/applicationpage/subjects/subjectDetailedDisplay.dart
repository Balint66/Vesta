import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/subjects/coursesDisplayer.dart';
import 'package:vesta/applicationpage/subjects/subjectDetailItem.dart';
import 'package:vesta/datastorage/courseData.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/subjectData.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataCourseRequest.dart';
import 'package:vesta/web/webdata/webDataCourseResponse.dart';
import 'package:vesta/web/webdata/webDataSubjectSignup.dart';

class SubjectDetailedDisplay extends StatelessWidget
{

  final SubjectData data;

  SubjectDetailedDisplay(SubjectData data) : data = data;

  @override
  Widget build(BuildContext context) 
  {

    var f = WebServices.getCourses(AccountManager.currentAccount.school, WebDataCourseRequest(AccountManager.currentAccount.webBase, Id: data.SubjectId, CurriculumID: data.CurriculumTemplateID, TermID: data.TermID));
    var translator = AppTranslations.of(context);


      return Scaffold(
        appBar: AppBar(title: Text('Subject Details')),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[

            SubjectDetailItem(translator.translate('subject_name'), data.SubjectName),
            SubjectDetailItem(translator.translate('subject_code'), data.SubjectCode),
            SubjectDetailItem(translator.translate('subject_req'), data.SubjectRequirement),
            SubjectDetailItem(translator.translate('subject_type'), data.SubjectSignupType),
            SubjectDetailItem(translator.translate('subject_credit'), '${data.Credit}'),
            //Here was the moment I decided not to make another stateful widget just for displaying the buttons.
            //It was a really fun time and I like the solution I came up with.
            //(Future me pls don't kill me)
            FutureBuilder(future: f, builder: (BuildContext ctx, AsyncSnapshot<WebDataCourseResponse?> snap)
            {
              if(!snap.hasData) {
                return CircularProgressIndicator();
              }

              var coursesByType = groupBy(snap.data!.CourseList, (CourseData obj)=>obj.CourseType_DNAME);
              var courses = List<int>.generate(coursesByType.length, (index) => -1);
              var entries = coursesByType.entries.toList();

              return Column(children:[ StatefulBuilder(builder:(BuildContext context, StateSetter setState)
              {
                
                return Column(children: List.generate(courses.length, (index)
                {

                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
                    child: Container(
                    color: Theme.of(context).primaryColor,
                      child: ListTile(
                        title: Center(child: Text(entries[index].key)),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoursesDisplayer(entries[index].value,(ind)
                        {
                            setState((){
                              courses[index] = ind;
                            });
                            Navigator.pop(context);
                        }),)),
                        subtitle: Center(child: Text("${courses[index] < 0 ? 'None' : entries[index].value[courses[index]].CourseCode}"))), ), );

                }));

              }),
            StatefulBuilder(builder: ( BuildContext context, StateSetter setState)
            {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Center(child: Text(data.IsOnSubject ? translator.translate('subject_leave') : translator.translate('subject_signup'))),
                    onTap: () async
                    {
                      try
                      {
                        var signed = await WebServices.saveSubject(Data.school!, WebDataSubjectSignupRequest(AccountManager.currentAccount.webBase, TermID: data.TermID,
                        SubjectID: data.SubjectId, CurriculumID: data.CurriculumTemplateID, IsOnSubject: data.IsOnSubject,
                        SubjectSignin: !data.IsOnSubject, CurriculumTemplatelineID: data.CurriculumTemplatelineID,
                        AllType: entries.map((e) => e.value[0].CourseType).toList(), CourseIDs: (()
                        {
                          var list = List<int>.generate(courses.length, (index) => 0);

                          for(var i = 0; i < courses.length; i++)
                          {
                            if(courses[i] == -1) {
                              continue;
                            }

                            list[i] = entries[i].value[courses[i]].Id;
                            
                          }

                          return list;
                        }).call()));

                        setState((){
                          data.IsOnSubject = signed!;
                        });

                      }
                      catch(e)
                      {
                        Vesta.showSnackbar(Text('$e'));
                      }
                    },
                  ),
                ),
              );

            })]);
            },)
      ])));  
  }

}