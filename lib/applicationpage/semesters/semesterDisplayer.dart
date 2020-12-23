import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/semesters/PeriodDetailedDisplay.dart';
import 'package:collection/collection.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/periodData.dart';
import 'package:vesta/i18n/appTranslations.dart';

class SemesterDisplayer extends StatefulWidget
{

  SemesterDisplayer({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() 
  {
    return _SemesterDisplayerState();  
  }

}

class _SemesterDisplayerState extends State<SemesterDisplayer>
{

  @override
  Widget build(BuildContext context) 
  {

    var list = MainProgram.of(context).semesterList;
    var translator = AppTranslations.of(context);


    return Column(children: [ FutureBuilder(future: list.getCurrentPeriod(), builder: (BuildContext futureContext, AsyncSnapshot<String> shot)
      {

      if(shot.hasError){
        return Center(child: Text(shot.error!.toString()));
      }

      if(shot.hasData)
      {

        return FutureBuilder(future: list.getPeriodTerms(), builder: ( BuildContext anotherContext, AsyncSnapshot<List<String>> data)
          {
            if(!data.hasData)
            {
              return Center(child: CircularProgressIndicator());
            }
            return PopupMenuButton(child: ListTile(title: Center(child: Text(shot.data!))), itemBuilder:(BuildContext cont)
              => List.generate(data.data!.length, (index) => PopupMenuItem(value: index, child: Text(data.data![index])),),
              onSelected: (int index){
                  setState((){
                    list.setPeriodTermIndex(index);
                    list.onUpdate();
                  });
                });
            
          });
        }
      

      return Center(child: CircularProgressIndicator());

      }),
      StreamBuilder(stream: list.getData(), builder: (BuildContext ctx, AsyncSnapshot<BaseDataList<PeriodData>> snap)
      {
        if(snap.hasData && snap.data!.isNotEmpty)
        {

          snap.data!.sort((element, other) => element.FromDate.compareTo(other.FromDate));

          Map<bool, dynamic> grouped = groupBy(snap.data!, (PeriodData element)=> element.ToDate.compareTo(DateTime.now()) < 0);
          grouped = grouped.map<bool, List<Widget>>((key, value) => MapEntry(key, value.map<Widget>((element) => ClickableCard(
          child: ListTile(title: Text('${element.PeriodName}'), 
                subtitle: Text('${element.PeriodTypeName}\n${Vesta.dateFormatter.format(element.FromDate)} - ${Vesta.dateFormatter.format(element.ToDate)}'),onTap:()
                => MainProgram.of(context).parentNavigator!.push(MaterialPageRoute(builder: (context) => PeriodDetailedDisplay(element),))),
          ) ).toList()));

          var ls = <Widget>[];
          if(grouped[true] != null)
          {
            ls.add(ExpansionTile(title: Text(translator.translate('semesters_ended')), children: grouped[true]));
          }

          if(grouped[false] != null)
          {
            ls.add(ExpansionTile(title: Text(translator.translate('semesters_notended')), children: grouped[false], initiallyExpanded: true,));
          }

          return Expanded(child: ListView( children: ls));
        }
        else {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }
      })
    ]);
  }
  
}