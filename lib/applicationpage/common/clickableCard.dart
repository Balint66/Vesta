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
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.of(context).primaryColor.withOpacity(0), Theme.of(context).primaryColor.withOpacity(0), _secondaryColor ?? (Theme.of(context).primaryColor) ]),
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