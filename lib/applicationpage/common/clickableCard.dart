import 'package:flutter/material.dart';
class ClickableCard extends StatelessWidget
{

  final Widget _child;

  ClickableCard({
    @required ListTile child
    }): _child = child;

  @override
  Widget build(BuildContext context)
  {
    return Card(
        child: Card(
          child: _child,
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6)
          ),
        elevation: 3,
        color: Theme.of(context).primaryColor,
      ); 
  }

}