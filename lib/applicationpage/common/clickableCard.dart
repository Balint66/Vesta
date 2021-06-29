import 'package:flutter/material.dart';
class ClickableCard extends StatelessWidget
{

  final Widget _child;
  final Color? _secondaryColor;

  ClickableCard({
    @required Widget? child,
    Color? secondColor
    }): _child = child ?? ListTile(), _secondaryColor = secondColor;

  @override
  Widget build(BuildContext context)
  {
    return Card(
      elevation: 3,
      color: _secondaryColor ?? Theme.of(context).primaryColor,
    child:Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0),
          borderRadius: BorderRadius.circular(10)
        ),
      child: Card(
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
          child: Container(
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(10)
              ), 
            child: _child,
            ), 
          ),
      ),
    ); 
  }

}