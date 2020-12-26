import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/common/gradientDivider.dart';
import 'package:vesta/applicationpage/common/textDetailItem.dart';
import 'package:vesta/datastorage/Lists/cache/examsCache.dart';
import 'package:vesta/datastorage/examDetails.dart';

class ExamDetailsDisplay extends StatefulWidget
{

  static final cache = ExamsCache();

  final String id;

  ExamDetailsDisplay(this.id);

  @override
  State<StatefulWidget> createState() => ExamDetailsDisplayState();

}

class ExamDetailsDisplayState extends State<ExamDetailsDisplay>
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: FutureBuilder(future: ExamDetailsDisplay.cache.getItem(widget.id), builder: (BuildContext context, AsyncSnapshot<ExamDetails> snapshot)
    {
      if(snapshot.hasError)
      {
        return Center(child:Text(snapshot.error.toString()));
      }

      if(!snapshot.hasData)
      {
        return Center(child:CircularProgressIndicator());
      }

      var data = snapshot.data!;

      return ListView.separated(itemCount: 14, separatorBuilder: (ctx, i)=> GradientDivider(), itemBuilder: (BuildContext context, int index)
      {
        switch(index)
        {
          case 0: return TextDetailItem('Test', data.ExamType_DNAME);
          case 1: return TextDetailItem('Test', data.FromDate);
          case 2: return TextDetailItem('Test', data.ToDate);
          case 3: return TextDetailItem('Test', data.MinStrength);
          case 4: return TextDetailItem('Test', data.MaxStrength);
          case 5: return TextDetailItem('Test', data.SigninFromDate);
          case 6: return TextDetailItem('Test', data.SigninToDate);
          case 7: return TextDetailItem('Test', data.ExamRooms);
          case 8: return TextDetailItem('Test', data.Strength.toString());
          case 9: return TextDetailItem('Test', data.WaitingStrength.toString());
          case 10: return TextDetailItem('Test', data.WaitingListCount.toString());
          case 11: return TextDetailItem('Test', data.Created.toString());
          case 12: return TextDetailItem('Test', data.Creator);
          case 13: return TextDetailItem('Test', data.Description);
          default:
            return Center(child: Text('Unknown item index'));
        }
      },);

    }),
    appBar: AppBar(title: Text('Exam'),));  
  }
  
}