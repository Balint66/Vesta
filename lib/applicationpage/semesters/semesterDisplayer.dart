import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/semesters/PeriodDetailedDisplay.dart';
import 'package:vesta/datastorage/Lists/semestersDataList.dart';

class SemesterDisplayer extends StatefulWidget
{

  SemesterDisplayer({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() 
  {
    return _SemesterDisplayerState();  
  }

}

class _SemesterDisplayerState extends State<SemesterDisplayer>
{

  static final data = PopupOptionData(
    builder:(BuildContext ctx){ return null; }, selector: (int value){}
  );

  @override
  Widget build(BuildContext context) 
  {

    var list = MainProgram.of(context).semesterList;


    return Column(children: [ FutureBuilder(future: list.getCurrentPeriod(), builder: (BuildContext futureContext, AsyncSnapshot<String> shot)
      {

      if(shot.hasError){
        return Center(child: Text(shot.error));
      }

      if(shot.hasData)
      {

        return FutureBuilder(future: list.getPeriodTerms(), builder: ( BuildContext anotherContext, AsyncSnapshot<List<String>> data)
          {
            if(!data.hasData)
            {
              return Center(child: CircularProgressIndicator());
            }
            return PopupMenuButton(child: ListTile(title: Center(child: Text(shot.data))), itemBuilder:(BuildContext cont)
              => List.generate(data.data.length, (index) => PopupMenuItem(value: index, child: Text(data.data[index])),),
              onSelected: (index){
                  setState((){
                    list.setPeriodTermIndex(index);
                    list.onUpdate();
                  });
                });
            
          });
        }
      

      return Center(child: CircularProgressIndicator());

      }),
      StreamBuilder(stream: list.getData(), builder: (BuildContext ctx, AsyncSnapshot<SemestersDataList> snap)
      {
        return snap.hasData ?
        Expanded(child: ListView.builder(itemBuilder: (BuildContext context,int index) => snap.data.map((element) => ClickableCard(
          child: ListTile(title: Text('${element.PeriodName}'), 
                subtitle: Text('${element.PeriodTypeName}\n${Vesta.dateFormatter.format(element.FromDate)} - ${Vesta.dateFormatter.format(element.ToDate)}'),onTap:()
                => MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (context) => PeriodDetailedDisplay(element),))),
          ) ).toList()[index], itemCount: snap.data.length))
          : Center(child: CircularProgressIndicator());
      })
    ]);
  }
  
}