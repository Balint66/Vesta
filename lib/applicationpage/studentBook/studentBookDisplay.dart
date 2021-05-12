import 'package:flutter/material.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/studentBookData.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';

class StudentBookDisplay extends StatefulWidget
{

  StudentBookDisplay({Key? key}) : super(key:key);

  @override
  State<StudentBookDisplay> createState()
  {
    return _StudentBookDisplayState();
  }

}

class _StudentBookDisplayState extends State<StudentBookDisplay>
{

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(stream: AccountManager.currentAccount.studentBook.getData(),builder:(BuildContext ctx, AsyncSnapshot<BaseDataList<StudentBookData>> snap)
    {

      if(snap.hasData)
      {

        var regex = RegExp(r'\(\d\)', unicode: true);

        var grades = snap.data!.map((e)=> int.parse(
          ((){
            var hasMatch = regex.hasMatch(e.Values);
            if(!hasMatch)
            {
              return '0';
            }
            else
            {
              var match = regex.allMatches(e.Values);
              return match.last.group(0)![1];
            }
            }).call()))
          .toList();

        var credIndex = snap.data!.where((e)=> e.Values.isNotEmpty).map((e)=> int.parse((()
        {
          var hasMatch = regex.hasMatch(e.Values);
            if(!hasMatch)
            {
              return '0';
            }
            else
            {
              var match = regex.allMatches(e.Values);
              return match.last.group(0)![1];
            }
        }).call()).toDouble() * e.Credit).fold(0, (prev, element) => (prev! as num) + element) / 30.0;

        double average;

        if(grades.where((element) => element != 0).isNotEmpty){
          average = grades.fold<int>(0, (prev, element) => prev + element) / grades.where((element) => element != 0).length.toDouble();
        }
        else
        {
          average = 0.0;
        }

        var credPercent = (snap.data!.where((e)=> e.Values.isNotEmpty).map((e) =>e.Credit).fold(0, (prev, e) => (prev! as num) + e) as int).toDouble() / 
            (snap.data!.map((e)=> e.Credit).fold(0,(prev, e) => (prev! as num) + e)).toDouble();

        var translator = AppTranslations.of(context);

        return Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Container( padding: EdgeInsets.fromLTRB(30, 15, 30, 7),child: Text("${translator.translate("studentbook_av")}: ${average.toStringAsFixed(2)}"), ),
            Container( padding: EdgeInsets.symmetric(horizontal:30, vertical:7),child: Text("${translator.translate("studentbook_ci")}: ${credIndex.toStringAsFixed(2)}"), ),
            Container( padding: EdgeInsets.fromLTRB(30, 7, 30, 15),child: Text("${translator.translate("studentbook_cci")}: ${ (credIndex * credPercent).toStringAsFixed(2)}"), )], ),
          Expanded( child: ListView(children: snap.data!.expand((element) => [Card(child: ListTile(
          leading: Icon(element.Completed ? Icons.check : Icons.close, color: element.Completed ? Colors.green : Colors.red),
          title: Text(element.SubjectName), 
          subtitle: Text(element.Values.replaceAll('<br/>', '\n'))))]).toList()))]);
          }

      return Center(child: CircularProgressIndicator());
    });
  }

}