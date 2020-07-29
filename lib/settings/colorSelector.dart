import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var ratio = (width*3)/(height*4);
    _chosenColor ??= Vesta.of(context).settings.mainColor;

    return AlertDialog
      (title: Text('Colors'),
      content: Center(
          child: Wrap(
            children: generateGrid(context, ratio, width, height),
            alignment: WrapAlignment.center,
            spacing: 10 * ratio * height/600,
            direction: Axis.vertical,
          )
      ),
      actions:  <Widget>[
        MaterialButton(
            child: Text('Custom'),
            onPressed: () => showDialog(context: context,
                builder: _customColorSelector())),
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        MaterialButton(
          onPressed: _chosenColor != Vesta.of(context).settings.mainColor
              ? (){ Vesta.of(context).updateSettings(mainColor: _chosenColor); Navigator.pop(context);} : null
          ,
          child: Text('Apply'),
        ),
      ],
    );
  }

  List<Widget> generateGrid(BuildContext context, double ratio, double width, double height)
  {

    var sqrtt = sqrt(Colors.primaries.length);

    var list = <Widget>[];

    for(var i = 0; i< sqrtt.round(); i++)
    {
      var rowList = <Widget>[];
      for(var j = 0; j< sqrtt.round(); j++)
      {
        
        var children = <Widget>[];
        
        if(Colors.primaries[(i*sqrtt).floor() + j].value == _chosenColor.value)
        {
          children.add(Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.primaries[(i*sqrtt).floor() + j],
              ),
            ),
          );
          children.add(Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withAlpha(127),
              ),
              child: Center(child: Icon(Icons.check, size: 25,color: Colors.white,)),
            )
          );
        }
        else
        {
          children.add( InkWell(
              child:Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
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
          Wrap(
            children: rowList,
            alignment: WrapAlignment.center,
            spacing: 10 * ratio * width/800,
          )
      );
      
    }

    return list;

  }

  WidgetBuilder _customColorSelector()
  {
    return (BuildContext context)
    {

      var _r = TextEditingController(text: _chosenColor.red.toString());
      var _g = TextEditingController(text: _chosenColor.green.toString());
      var _b = TextEditingController(text: _chosenColor.blue.toString());

      var r = int.tryParse(_r.value.text), g = int.tryParse(_g.value.text), b = int.tryParse(_b.value.text);

      return AlertDialog(
        title:  Text('Custom'),
        content: StatefulBuilder(builder: ( BuildContext context, StateSetter setInnerState)
        {

          _r.addListener(() { setInnerState(()
          {
            if(_r.value.text != null && _r.value.text.isNotEmpty) {
              r = int.tryParse(_r.value.text);
            } 
            else {
              r = 0;
            }
          }); });

          _g.addListener(() { setInnerState(()
          {
            if(_g.value.text != null && _g.value.text.isNotEmpty) {
              g = int.tryParse(_g.value.text);
            } 
            else {
              g = 0;
            }
          }); });

          _b.addListener(() { setInnerState(()
          {
            if(_b.value.text != null && _b.value.text.isNotEmpty) {
              b = int.tryParse(_b.value.text);
            } 
            else {
              b = 0;
            }
          }); });

          return Column(children: [ Container(width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, r, g, b),
          ),
        ), 
        SingleChildScrollView(child: Center(
          child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _r,
                  decoration: InputDecoration(labelText: 'Red'),
                ),
                TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _g,
                  decoration: InputDecoration(labelText: 'Green'),
                ),
                TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _b,
                  decoration: InputDecoration(labelText: 'Blue'),
                ),
              ],
          ),
        )),
        ]);}),
        actions: <Widget>[
          MaterialButton(onPressed: ()=>Navigator.of(context).pop(),
          child: Text('Cancel'),),

          MaterialButton(onPressed: ()
          {

            var col = Color.fromARGB(255,
                int.tryParse(_r.value.text),
                int.tryParse(_g.value.text),
                int.tryParse(_b.value.text));

            setState(() {
              _chosenColor = col;
            });

            Vesta.of(context).updateSettings(mainColor: col);
            var nav = Navigator.of(context);
            nav.pop();
            nav.pop();
          },
            child: Text('Apply'),
          ),
        ],
      );

    };

  }

}