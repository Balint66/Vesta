import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/school/schoolList.dart';

class SchoolSelectionButton extends StatefulWidget
{
  final SchoolList schools;
  final SchoolButtonState state;

  SchoolSelectionButton(this.schools,{Key key}):
        state = new SchoolButtonState(schools),
        super(key:key);

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class SchoolButtonState extends State<SchoolSelectionButton>
{

  String text = "Iskolák...";
  final SchoolList schools;
  School choosen;

  SchoolButtonState(this.schools,{Key key});

  @override
  void initState()
  {
    text = "Iskolák...";
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialButton
      (
      color: Colors.white,
      child: new Container( child: new Text(text,textWidthBasis: TextWidthBasis.parent, maxLines: 2,textScaleFactor: 1.125,), width: 200.5,),
      onPressed: ()=>displaySchoolsAndChoose(context),
    );
  }

  void displaySchoolsAndChoose(BuildContext context) async
  {

     choosen = await showDialog<School>(
      context: context,
      builder: (BuildContext context)
      {
        return SimpleDialog(
          title: const Text("Iskolák:"),
          children: getChoosableSchools(schools),
          elevation: 1,
        );

      },
    );

    setState(() {
      Data.school = choosen;
      text = choosen != null ? choosen.Name : "Iskolák..";
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