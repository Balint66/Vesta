import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/Lists/schoolList.dart';
import 'package:vesta/i18n/appTranslations.dart';

class SchoolSelectionButton extends StatefulWidget
{

  final SchoolList _schools;
  final FormFieldState<School> _formState;

  SchoolSelectionButton(this._schools, this._formState,{Key key}):
        super(key:key);

  @override
  State<StatefulWidget> createState() {
    return new SchoolButtonState();
  }
}

class SchoolButtonState extends State<SchoolSelectionButton>
{

  String text = "Iskolák...";
  School chosen;

  @override
  void initState()
  {
    text = AppTranslations.of(context).translate("login_schools_button");
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return new Column(
      children: getErrorTextedButton(context),
    );
  }

  List<Widget> getErrorTextedButton(BuildContext context)
  {
    List<Widget> list = new List<Widget>();

    list.add(new MaterialButton
      (
      color: Theme.of(context).brightness == Brightness.dark? Theme.of(context).backgroundColor : Colors.white,
      child: new Container( child: new Text(text,textWidthBasis: TextWidthBasis.parent, maxLines: 2,textScaleFactor: 1.125,), width: 200.5,),
      onPressed: ()=>displaySchoolsAndChoose(context),
      ),
    );

    if(widget._formState.errorText != null && widget._formState.errorText.isNotEmpty)
    {

      InputDecoration dec = const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme);

      TextStyle stl =  dec.errorStyle ?? new TextStyle();

      stl = stl?.copyWith(color: Colors.red, fontSize: 12);

      list.add(new Text(widget._formState.errorText,
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
          title: new Text(AppTranslations.of(context).translate("login_schools")),
          children: getChoosableSchools(widget._schools),
          elevation: 1,
        );

      },
    );

    setState(()
    {
      widget._formState.didChange(chosen);
      Data.school = chosen;
      text = chosen != null ? chosen.Name : AppTranslations.of(context).translate("login_schools_button");
    });


  }

  List<Widget> getChoosableSchools(SchoolList sch)
  {
    List<Widget> list = new List<Widget>();

    for(var item in sch.schools)
    {

      if(item.Url==null)
        continue;

      list.add(Container(
        height: 70,
        child: SimpleDialogOption(
          child: Text(item.Name,
            textScaleFactor: 1.5,
          ),
          onPressed: ()
          {
            Navigator.pop(context,item);
          },
        ),
       ),
      );

    }

    return list;

  }

}