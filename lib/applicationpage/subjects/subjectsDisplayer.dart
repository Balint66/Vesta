import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/clickableCard.dart';
import 'package:vesta/applicationpage/common/refreshExecuter.dart';
import 'package:vesta/applicationpage/subjects/subjectDetailedDisplay.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:collection/collection.dart';
import 'package:vesta/datastorage/subjectData.dart';
import 'package:vesta/i18n/appTranslations.dart';

class SubjectDisplayer extends StatefulWidget
{

  SubjectDisplayer({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState()
  {
    return _SubjectDisplayerState();  
  }

}

class _SubjectDisplayerState extends State<SubjectDisplayer>
{


  @override
  Widget build(BuildContext context)
  {

    var translator = AppTranslations.of(context);

    return StreamBuilder(stream: MainProgram.of(context).subject.getData(), builder: (BuildContext ctx, AsyncSnapshot<BaseDataList<SubjectData>> snap)
      {
        if( !snap.hasData || snap.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        snap.data!.sort((e,k)=>e.SubjectName.compareTo(k.SubjectName));

        var ls = <Widget>[];

        var completed = groupBy(snap.data!, (SubjectData item)=>item.Completed);

        if(completed[true] != null){
          ls.add(ExpansionTile(title: Text(translator.translate('subjects_completed')), children: completed[true]!.map((e) => _visualizeItem(e)).toList()));
        }

        if(completed[false] != null)
        {

          var isOn = groupBy(completed[false]!, (SubjectData item)=>item.IsOnSubject);

          if(isOn[true] != null){
            ls.add(ExpansionTile(title: Text(translator.translate('subjects_selected')), children: isOn[true]!.map((e) => _visualizeItem(e)).toList()));
          }

          if(isOn[false] != null){
            ls.add(ExpansionTile(title: Text(translator.translate('subjects_neutral')), initiallyExpanded: true, children: isOn[false]!.map((e) => _visualizeItem(e)).toList()));
          }

        }

        return RefreshExecuter(
          child: ListView(children: ls,),
        asyncCallback: MainProgram.of(context).subject.incrementDataIndex,
        );

      }
    );  
  }

  ClickableCard _visualizeItem(SubjectData element)
  {
    return ClickableCard(
            child: ListTile(leading: element.IsOnSubject ? Icon(Icons.indeterminate_check_box, color: Colors.blue) 
            : element.Completed ? Icon(Icons.check_box , color: Colors.green) : Icon(Icons.check_box_outline_blank, color: Colors.grey),
            title: Text(element.SubjectName), subtitle: Text('${element.SubjectCode}\n${element.SubjectRequirement}'),
            onTap: () {
              MainProgram.of(context).parentNavigator.push(MaterialPageRoute(builder: (ctx)=>SubjectDetailedDisplay(element)));
            },)
            );
  }
  
}