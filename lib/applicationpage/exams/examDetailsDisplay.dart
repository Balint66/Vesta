import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vesta/applicationpage/common/gradientDivider.dart';
import 'package:vesta/applicationpage/common/textDetailItem.dart';
import 'package:vesta/datastorage/Lists/cache/examsCache.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/examData.dart';
import 'package:vesta/datastorage/examDetails.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataExamSignup.dart';

class ExamDetailsDisplay extends StatefulWidget
{

  static final cache = ExamsCache();

  final Exam exam;

  ExamDetailsDisplay(this.exam);

  @override
  State<StatefulWidget> createState() => ExamDetailsDisplayState();

}

class ExamDetailsDisplayState extends State<ExamDetailsDisplay>
{
  @override
  Widget build(BuildContext context) 
  {

    final translator = AppTranslations.of(context);

    return Scaffold(
      body: FutureBuilder(future: ExamDetailsDisplay.cache.getItem(widget.exam.ExamID), builder: (BuildContext context, AsyncSnapshot<ExamDetails> snapshot)
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
          case 0: return TextDetailItem(translator.translate('exam_type'), data.ExamType_DNAME); //Típusa
          case 1: return TextDetailItem(translator.translate('exam_begin'), data.FromDate); // Kezdete
          case 2: return TextDetailItem(translator.translate('exam_end'), data.ToDate); // vége
          case 3: return TextDetailItem(translator.translate('exam_min_count'), data.MinStrength); // Min létszám
          case 4: return TextDetailItem(translator.translate('exam_max_count'), data.MaxStrength); // Max létszám
          case 5: return TextDetailItem(translator.translate('exam_signin_begin'), data.SigninFromDate); // Feliratkozás kezdete
          case 6: return TextDetailItem(translator.translate('exam_signin_end'), data.SigninToDate); // Feliratkozás vége
          case 7: return TextDetailItem(translator.translate('exam_rooms'), data.ExamRooms); // Vizsga helyszíne(i)
          case 8: return TextDetailItem(translator.translate('exam_signedin'), data.Strength.toString()); // Feliratkozottak
          case 9: return TextDetailItem(translator.translate('exam_waitinglist'), data.WaitingStrength.toString()); // Várólista
          case 10: return TextDetailItem(translator.translate('exam_waitinglist_count'), data.WaitingListCount.toString()); // várólistások
          case 11: return TextDetailItem(translator.translate('exam_created'), data.Created.toString()); // Létrehozva
          case 12: return TextDetailItem(translator.translate('exam_creator'), data.Creator); // Készítette
          case 13: return TextDetailItem(translator.translate('exam_desc'), data.Description); // Leírás
          default:
            return Center(child: Text('Unknown item index'));
        }
      },);

    }),
    appBar: AppBar(title: Text(translator.translate('exam')),),
    floatingActionButton: Container(child:TextButton.icon(icon: Icon(widget.exam.FilterExamType == 1 ? FeatherIcons.minus : FeatherIcons.plus,), //TODO:replace icons
      label: Container(),
      onPressed: () async {
          var resp = await WebServices.setExamSigning(AccountManager.currentAcount.school, WebDataExamSignup(AccountManager.currentAcount, widget.exam.CourseID, widget.exam.ExamID));
          widget.exam.FilterExamType == 1 ? 0 : 1;
          await showDialog(context: context, builder: (ctx) => AlertDialog(content: Text(resp!.Message!),));
        }),height: 60, width:60, margin: EdgeInsets.only(bottom: 50, right: 10),
    ),);  
  }
  
}