import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/Lists/schoolList.dart';
import 'login.i18n.dart';

class SchoolSelectionButton extends StatefulWidget
{

  final SchoolList _schools;
  final FormFieldState<School> _formState;

  SchoolSelectionButton(this._schools, this._formState,{Key? key}):
        super(key:key);

  @override
  State<StatefulWidget> createState() {
    return SchoolButtonState();
  }
}

class SchoolButtonState extends State<SchoolSelectionButton>
{

  String? text;
  School? chosen;

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    text = Data.school == null ? ('schools_button'.i18n) : Data.school?.Name;

    return Column(
      children: getErrorTextedButton(context),
    );
  }

  List<Widget> getErrorTextedButton(BuildContext context)
  {
    
    var list = <Widget>[];

    list.add(MaterialButton
      (
      color: Theme.of(context).brightness == Brightness.dark? Theme.of(context).backgroundColor : Colors.white,
      onPressed: ()=>displaySchoolsAndChoose(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container( width: 200.5, padding: EdgeInsets.all(10), child: Text(text ?? '',textWidthBasis: TextWidthBasis.parent, maxLines: 2,textScaleFactor: 1.125, textAlign: TextAlign.center,),),
      ),
    );

    if(widget._formState.errorText != null && (widget._formState.errorText?.isNotEmpty ?? false))
    {

      var dec = const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme);

      var stl =  dec.errorStyle ?? TextStyle();

      stl = stl.copyWith(color: Colors.red, fontSize: 12);

      list.add(Text(widget._formState.errorText ?? '',
        style: stl));
    }

    return list;

  }

  void displaySchoolsAndChoose(BuildContext context) async
  {

      chosen = await showDialog<School>(
      context: context,
      builder: (BuildContext context)
      {
        return SimpleDialog(
          title: Container(
            padding: EdgeInsets.fromLTRB(0,0,0,24),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: Center(child: Text('schools'.i18n), 
            ),
            ),
          contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 20.0),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          children: getChoosableSchools(widget._schools),
        );

      },
    );

    setState(()
    {
      widget._formState.didChange(chosen);
      Data.school = chosen;
      text = chosen != null ? chosen?.Name : 'schools_button'.i18n;
    });


  }

  List<Widget> getChoosableSchools(SchoolList sch)
  {
    var list = <Widget>[];

    for(var item in sch.schools)
    {

      if(item.Url == null)
      {
        continue;
      }

      list.add(Container(
        height: 70,
        child: SimpleDialogOption(
          onPressed: ()
          {
            Navigator.pop(context,item);
          },
          child: Text(item.Name,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      );

    }

    return list;

  }

}