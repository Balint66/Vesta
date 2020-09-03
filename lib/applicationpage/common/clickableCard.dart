import 'package:flutter/material.dart';
class ClickableCard extends StatelessWidget
{

  final Widget _child;
  final Color _secondaryColor;

  ClickableCard({
    @required ListTile child,
    Color secondColor
    }): _child = child, _secondaryColor = secondColor;

  @override
  Widget build(BuildContext context)
  {
    return Card(
    child:Container(
      child: Card(
          child: _child,
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6)
          ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.of(context).primaryColor.withOpacity(0), Theme.of(context).primaryColor.withOpacity(0), _secondaryColor ?? Theme.of(context).primaryColor ]),
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      elevation: 3,
      color: Theme.of(context).primaryColor,
    ); 
  }

}