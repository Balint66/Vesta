import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/kamonjiDisplayer.dart';
import 'package:vesta/applicationpage/exams/examDetailsDisplay.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/examData.dart';
import 'package:intl/intl.dart';

class ExamListDisplay extends StatefulWidget
{

  static final examDateFormat = DateFormat('MM. dd. hh:mm');

  ExamListDisplay({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExamListDisplayState();
}

class ExamListDisplayState extends State<ExamListDisplay>
{

  @override
  Widget build(BuildContext context) 
  {
    final exams = MainProgram.of(context).examList;

    return StreamBuilder(stream: exams.getData(), builder:(BuildContext context, AsyncSnapshot<BaseDataList<Exam>> snapshot)
    {
      if(snapshot.hasError)
      {
        return Center(child: Text(snapshot.error!.toString()));
      }

      if(!snapshot.hasData)
      {
        return FutureBuilder(future: Future.delayed(Duration(seconds: 3),()=>true), builder:(BuildContext context, snap)
        {
          if(snap.hasData){
            return KamonjiDisplayer(RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text:'', style: Theme.of(context).textTheme.bodyText1, children: <InlineSpan>[
              TextSpan(text: 'Σ(･ω･ﾉ)ﾉ！', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25))
            ])
            ));
            }
            return Center(child:CircularProgressIndicator());
          });
      }
      return ListView.builder(itemCount: snapshot.data!.length, itemBuilder: (BuildContext context ,int index)
      {

        var data = snapshot.data![index];

        return ClickableCard(child: ListTile(
          title: Text(snapshot.data![index].SubjectName, style: data.FilterExamType == 0 ? null : Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).primaryColor),),
          trailing: Text(ExamListDisplay.examDateFormat.format(data.FromDate) + '\n' + ExamListDisplay.examDateFormat.format(data.ToDate)),
          onTap: ()=> MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=> ExamDetailsDisplay(data)))));
      });
    });

  }
}