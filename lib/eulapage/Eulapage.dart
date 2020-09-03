import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';

class Eula extends StatefulWidget
{
  final textstile = TextStyle(fontSize: 15.0, color: Colors.white);
  final controller = PageController(); 

  @override
  State<StatefulWidget> createState()
  {
    return _EulaState();
  }

}

Widget _wrapTextInWidget(List<Widget> texts, {Color color})
{
  return _MyAnimatedOpacity(child:SafeArea(child:  Container(padding: EdgeInsets.all(10), child: Card(color: color ?? Colors.blue, child: Center(
        child:Container(padding: EdgeInsets.all(12), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: texts,)),),),),),);
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

    var widgetList = <Widget>[
      _wrapTextInWidget([
          Image.asset('assets/icon/vesta.png',cacheWidth: 200,), //TODO:Better image display?
          Text(translator.translate('welcome'), style: TextStyle(fontSize: 26.0, color: Colors.white),),
          Text(translator.translate('short_description_0'), style: widget.textstile,),
          Text(translator.translate('short_description_1'), style: widget.textstile,)
        ]),
      _wrapTextInWidget([
          Text(translator.translate('description_0'),
          textAlign: TextAlign.center, style: widget.textstile,),
          Text(translator.translate('description_1'),
          textAlign: TextAlign.center, style: widget.textstile,),
          Text(translator.translate('description_2'),
          textAlign: TextAlign.center, style: widget.textstile,),
          Text(translator.translate('description_3'),
          textAlign: TextAlign.center, style: widget.textstile,)
        ], color: Colors.green),
      _wrapTextInWidget([
          Text(translator.translate('notice_0'),
          textAlign: TextAlign.center, style: widget.textstile,),
          Text(translator.translate('notice_1'),textAlign: TextAlign.center, style: TextStyle(fontSize: 19.0, color: Colors.white),),
          RaisedButton(child: Text(translator.translate('to_login')), onPressed: ()
          {
              Vesta.of(context).updateSettings(eulaWasAccepted:true);
              Navigator.pushReplacementNamed(context, '/login');
          })
        ], color: Colors.red)
    ];

    return Scaffold(
        body: Stack(children:[
          PageView
          (
            controller: widget.controller,
            children: widgetList,
            onPageChanged: (int i)=>setState((){}),
          ),
            _button(context) ,
          ]
        )
    );
  }

  Widget _button(BuildContext context)
  {

    var query = MediaQuery.of(context).size;
    var lr = (query.width/1280);
    var tb = (query.height/720);
    var min = (log((sqrt(lr*tb)+1)/2)+1)*35;
    var offset = 225;

    var pos = Positioned(left: (query.width/2) - min, right: (query.width/2) - min, bottom: (query.height/2) - min - tb*offset , top: (query.height/2) - min + tb*offset,
          child: GestureDetector(
            onTap: ()=>widget.controller.nextPage(duration: Duration(seconds:3), curve: Curves.fastLinearToSlowEaseIn),
            child: Card(shape: CircleBorder(), child: Icon(Icons.keyboard_arrow_right))),);

    var noll = Container();

    try{
        return widget.controller != null && widget.controller.page < 1.5 ? pos : noll;
    }
    catch(e)
    {
        return pos;
    }
  }

}


class _MyAnimatedOpacity extends StatefulWidget
{
  final Widget _child;

    _MyAnimatedOpacity({Key key, Widget child})
      : _child = child,
        super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return _MyAnimatedOpacityState();
  }


}

class _MyAnimatedOpacityState extends State<_MyAnimatedOpacity> with SingleTickerProviderStateMixin
{

  AnimationController _controller;

  @override
  void initState()
  {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.addListener(() {setState(() {});});

    animate();

  }

  @override
  Widget build(BuildContext context)
  {
      return Opacity(
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