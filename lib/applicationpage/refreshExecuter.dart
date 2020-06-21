import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;


typedef IncrementionCallback = Future<void> Function();

class RefreshExecuter extends StatefulWidget
{

  final Widget _child;

  final Tween<double> _place = new Tween<double>(begin: -70, end: 10);
  final Tween<double> _waitingPlace = new Tween<double>(begin: 60, end: 10);
  final IncrementionCallback _callback;
  final IconData _icon;

  RefreshExecuter({@required Widget child, @required IncrementionCallback asyncCallback,
        IconData icon})
      : this._child = child, this._callback = asyncCallback, this._icon = icon;

  @override
  State<StatefulWidget> createState()
  {
    return new RefreshExecuterState();
  }

}

class RefreshExecuterState extends State<RefreshExecuter> with SingleTickerProviderStateMixin
{

  AnimationController _controller;
  Animation<double> animation;

  bool _wasRequested = false;

  @override
  void initState()
  {
    super.initState();
    _controller = new AnimationController(vsync: this,
        duration: const Duration(seconds: 1));

    final CurvedAnimation _curved = new CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    animation = widget._waitingPlace
        .animate(_curved)
      ..addListener(()
      {

        setState(() {

        if(animation.value == widget._waitingPlace.end && !_wasRequested)
        {
          _wasRequested = true;
          Future.delayed(Duration(microseconds: 1), () async {
            await widget._callback();

            _animate = false;
            _controller.value = 0;

            _wasRequested = false;

          });
        }

        });

      });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _size = 30;

  @override
  Widget build(BuildContext context)
  {

      return new Stack(children: [new ScrollConfiguration(
          behavior: new OverScrollBehavior() ,
          child:  new NotificationListener<ScrollNotification>(
              onNotification: _listenScrollNotification,
            child: widget._child
          )
      ),
      new Positioned(
        child: new Card(
          child: new Container(
            width: _size,
            height: _size,
            padding: EdgeInsets.all(5),
            child: !_animate ? new Center(child: new Icon( widget._icon != null ? widget._icon : Icons.add,
                color: Theme.of(context).primaryColor,),)
                : CircularProgressIndicator(strokeWidth: 2.5,),),
          shape: CircleBorder(),),
        bottom: _animate
            ? animation.value
            : widget._place.transform(_clampedPosition),
        left: ( MediaQuery.of(context).size.width - _size) / 2,
      )
    ]);
  }

  bool _scrolledDown = false;
  bool _animate = false;
  bool _charged = false;
  double _overScrollPosition = 0;
  double _clampedPosition = 0;

  bool _listenScrollNotification(ScrollNotification notification)
  {
    if(_animate)
      return false;

    if(notification is ScrollEndNotification)
    {
      if(_charged)
      {
        setState(()
        {
          _charged = false;
          _animate = true;
          _controller.forward(from: 0);
        });

      }
    }

    if(notification is UserScrollNotification)
    {
      setState(() {
        _scrolledDown = notification.direction == ScrollDirection.reverse;
      });

    }

    if(_scrolledDown && (notification is OverscrollNotification))
    {
      if(notification is OverscrollNotification)
      {
        setState(() {
        _overScrollPosition += notification.overscroll;

        });
      }

    }
    else
    {
      setState(() {
      _overScrollPosition = 0;
      _charged = false;
      });
    }


    setState(()
    {
      if(_overScrollPosition < 300)
      {
        _clampedPosition = (Math.e/(1 + Math.exp(2.5-(_overScrollPosition)/100)));

      }
      else
        setState(() {
          _charged = true;
        });

    });

    return false;
  }

}

class OverScrollBehavior extends ScrollBehavior
{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child,
      AxisDirection axisDirection)
  {
    return child;
  }

}
