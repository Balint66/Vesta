import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';

class Eula extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return new _EulaState();
  }

}

class _EulaState extends State<Eula> with SingleTickerProviderStateMixin
{

  @override
  void initState()
  {
    super.initState();

   

  }

  @override
  Widget build(BuildContext context)
  {

    var translator = AppTranslations.of(context);

    List<Widget> widgetList = <Widget>[
      new _MyAnimatedOpacity(child:new SafeArea(child:  new Container(padding: EdgeInsets.all(10), child: new Card(color: Colors.blue, child: new Center(
        child:new Container(padding: EdgeInsets.all(12), child: new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
         // new Image.asset("assets/icon/vesta.png",scale: 0.4,), TODO:Better image display?
          new Text(translator.translate("welcome"), style: new TextStyle(fontSize: 26.0,),),
          new Text(translator.translate("short_description_0"), style: new TextStyle(fontSize: 15.0),),
          new Text(translator.translate("short_description_1"), style: new TextStyle(fontSize: 15.0),)
        ],)),),),),),),
      new _MyAnimatedOpacity(child: new SafeArea(child:new Container(padding: EdgeInsets.all(10), child: new Card(color: Colors.green, child: new Center(
        child: new Container(padding: EdgeInsets.all(12) ,child: new Column( mainAxisAlignment: MainAxisAlignment.center, children:
        [
          new Text(translator.translate("description_0"),
          textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0),),
          new Text(translator.translate("description_1"),
          textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0),),
          new Text(translator.translate("description_2"),
          textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0),),
          new Text(translator.translate("description_3"),
          textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0),)
        ])
      ),),),),),),
      new _MyAnimatedOpacity(child:new SafeArea(child: new Container(padding: EdgeInsets.all(10), child: new Card(color: Colors.red, child: new Center(
        child: new Container(padding: EdgeInsets.all(12) ,child: new Column( mainAxisAlignment: MainAxisAlignment.center, children:
        [
          new Text(translator.translate("notice_0"),
          textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0),),
          new Text(translator.translate("notice_1"),textAlign: TextAlign.center, style: new TextStyle(fontSize: 19.0),),
          new RaisedButton(child: new Text(translator.translate("to_login")), onPressed: ()
          {
              Vesta.of(context).updateSettings(eulaWasAccepted:true);
              Navigator.pushReplacementNamed(context, "/login");
          })
        ])
      ),),),),),),
    ];

    return new Scaffold(
        body: new PageView.builder
        (
            itemBuilder: (context, index) 
              {
                if(index < widgetList.length)
                {
                  return widgetList[index];
                }
                return null;
              },
        )
    );
  }

}


class _MyAnimatedOpacity extends StatefulWidget
{
  final Widget _child;

    _MyAnimatedOpacity({Key key, Widget child})
      : this._child = child,
        super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return new _MyAnimatedOpacityState();
  }

  Function animate = (){}; 


}

class _MyAnimatedOpacityState extends State<_MyAnimatedOpacity> with SingleTickerProviderStateMixin
{

  AnimationController _controller;

  @override
  void initState()
  {
    super.initState();

    _controller = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    _controller.addListener(() {setState(() {});});

    widget.animate = animate;

    animate();

  }

  @override
  Widget build(BuildContext context)
  {
      return new Opacity(
        opacity: _controller.value,
        child: widget._child,);
  }

  void animate()
  {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

}