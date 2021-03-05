import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;


typedef IncrementionCallback = Future<void> Function();

class RefreshExecuter extends StatefulWidget
{

  final Widget _child;

  final Tween<double> _place = Tween<double>(begin: -70, end: 10);
  final Tween<double> _waitingPlace = Tween<double>(begin: 60, end: 10);
  final IncrementionCallback _callback;
  final IconData _icon;

  RefreshExecuter({@required Widget? child, @required IncrementionCallback? asyncCallback,
        IconData icon = Icons.add})
      : _child = child ?? Container(), _callback = asyncCallback ?? (() async {}), _icon = icon;

  @override
  State<StatefulWidget> createState()
  {
    return RefreshExecuterState();
  }

}

class RefreshExecuterState extends State<RefreshExecuter> with SingleTickerProviderStateMixin
{

  AnimationController? _controller;
  Animation<double>? animation;

  bool _wasRequested = false;

  @override
  void initState()
  {
    super.initState();
    _controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 1));

    final _curved = CurvedAnimation(parent: _controller as AnimationController, curve: Curves.elasticInOut);

    animation = widget._waitingPlace
        .animate(_curved)
      ..addListener(()
      {

        setState(() {

        if(animation?.value == widget._waitingPlace.end && !_wasRequested)
        {
          _wasRequested = true;
          Future.delayed(Duration(microseconds: 1), () async {
            await widget._callback();

            _animate = false;
            _controller?.value = 0;

            _wasRequested = false;

          });
        }

        });

      });

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  final _size = 30.0;

  @override
  Widget build(BuildContext context)
  {

      return Stack(children: [ScrollConfiguration(
          behavior: OverScrollBehavior() ,
          child:  NotificationListener<ScrollNotification>(
              onNotification: _listenScrollNotification,
            child: widget._child
          )
      ),
      Positioned(
        bottom: _animate
            ? animation?.value
            : widget._place.transform(_clampedPosition),
        left: ( MediaQuery.of(context).size.width - _size) / 2,
        child: Card(
          shape: CircleBorder(),
          child: Container(
            width: _size,
            height: _size,
            padding: EdgeInsets.all(5),
            child: !_animate ? Center(child: Icon( widget._icon,
                color: Theme.of(context).primaryColor,),)
                : CircularProgressIndicator(strokeWidth: 2.5,),),),
      )
    ]);
  }

  var _scrolledDown = false;
  var _animate = false;
  var _charged = false;
  var _overScrollPosition = 0.0;
  var _clampedPosition = 0.0;

  bool _listenScrollNotification(ScrollNotification notification)
  {
    if(_animate) {
      return false;
    }

    if(notification is ScrollEndNotification)
    {
      if(_charged)
      {
        setState(()
        {
          _charged = false;
          _animate = true;
          _controller?.forward(from: 0);
        });

      }
    }

    if(notification is UserScrollNotification)
    {
      setState(() {
        _scrolledDown = notification.direction == ScrollDirection.reverse && notification.metrics.axis == Axis.vertical;
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
        _clampedPosition = (math.e/(1 + math.exp(2.5-(_overScrollPosition)/100)));

      }
      else {
        setState(() {
          _charged = true;
        });
      }

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
