import 'package:flutter/material.dart';
class ClickableCard extends StatelessWidget
{

  final Widget _child;
  final Color? _secondaryColor;

  ClickableCard({
    @required ListTile? child,
    Color? secondColor
    }): _child = child ?? ListTile(), _secondaryColor = secondColor;

  @override
  Widget build(BuildContext context)
  {
    return Card(
      elevation: 3,
      color: Theme.of(context).primaryColor,
    child:Container(
      child: Card(
          child: Container( 
            child: _child,
            decoration: BoxDecoration( 
              border: _secondaryColor == null 
                ? null 
                : Border.all(color: _secondaryColor!,
                  width: 3.0),
              borderRadius: BorderRadius.circular(5)
              )
            ),
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6)
          ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0),
          borderRadius: BorderRadius.circular(5)
        ),
      child: Card(
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: _child,
          ),
      ),
    ); 
  }

}