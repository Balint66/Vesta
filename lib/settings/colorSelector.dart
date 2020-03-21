import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';

class ColorSelector extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _ColorSelectorState();
  }



}

class _ColorSelectorState extends State<ColorSelector>
{

  Color _chosenColor;

  @override
  Widget build(BuildContext context)
  {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = (width*3)/(height*4);
    if(_chosenColor == null)
      _chosenColor = Vesta.of(context).settings.mainColor;

    return new AlertDialog
      (title: new Text("Colors"),
      content: new Center(
          child: new Wrap(
            children: generateGrid(context, ratio, width, height),
            alignment: WrapAlignment.center,
            spacing: 10 * ratio * height/600,
            direction: Axis.vertical,
          )
      ),
      actions:  <Widget>[
        new MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: new Text("Cancel"),
        ),
        new MaterialButton(
          onPressed: _chosenColor != Vesta.of(context).settings.mainColor
              ? (){ Vesta.of(context).updateSettings(mainColor: _chosenColor); Navigator.pop(context);} : null
          ,
          child: new Text("Apply"),
        ),
      ],
    );
  }

  List<Widget> generateGrid(BuildContext context, double ratio, double width, double height)
  {

    double sqrtt = sqrt(Colors.primaries.length);

    List<Widget> list = new List<Widget>();

    for(int i = 0; i< sqrtt.round(); i++)
    {
      List<Widget> rowList = new List();
      for(int j = 0; j< sqrtt.round(); j++)
      {
        
        List<Widget> children = new List();
        
        if(Colors.primaries[(i*sqrtt).floor() + j].value == _chosenColor.value)
        {
          children.add(new Container(
              width: 35,
              height: 35,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.primaries[(i*sqrtt).floor() + j],
              ),
            ),
          );
          children.add(new Container(
              width: 35,
              height: 35,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withAlpha(127),
              ),
              child: new Center(child: new Icon(Icons.check, size: 25,color: Colors.white,)),
            )
          );
        }
        else
        {
          children.add( new InkWell(
              child:new Container(
                width: 35,
                height: 35,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[(i*sqrtt).floor() + j],
                ),
              ),
              onTap: ()
              {
                setState(() {
                    _chosenColor = Colors.primaries[(i*sqrtt).floor() + j];
                });
              },
            )
          );
        }
        
        rowList.add(
            Stack(children: children,)
        );

      }

      list.add(
          new Wrap(
            children: rowList,
            alignment: WrapAlignment.center,
            spacing: 10 * ratio * width/800,
          )
      );
      
    }

    return list;

  }

}