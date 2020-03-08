import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_support/overlay_support.dart';


class MessageManager extends StatelessWidget
{

  static BuildContext _ctx;

  final Widget _child;

  MessageManager({Widget child ,Key key}) : this._child = child, super(key:key);

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return _child;
  }

  static void showSnackBar(Widget message)
  {
    Scaffold.of(_ctx).showSnackBar(new SnackBar(content: message));
  }

  static void showToast(String message)
  {
    toast(message);
  }


}