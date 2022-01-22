import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    var divData = DividerTheme.of(context);
    var theme = Theme.of(context);

    final thickness = divData.thickness ?? 0.5;
    final indent = divData.indent ?? 0.0;
    final endIndent = divData.endIndent ?? 0.0;

      return Center( child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[theme.primaryColor, theme.canvasColor],
              stops: [0.0, 0.75]
          ),
        ),
        height: thickness * 5,
        margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
      ));  
  }

}