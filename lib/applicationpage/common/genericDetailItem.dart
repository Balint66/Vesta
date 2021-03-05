import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailItem extends StatelessWidget
{

  final String category;
  final Widget item;

  DetailItem(this.category, this.item);

  @override
  Widget build(BuildContext context) 
  {
    var theme = Theme.of(context); 
    return Column(children: [
      Text(category, style: theme.textTheme.caption),
      Container(padding: EdgeInsets.all(4), child: item, )
    ],);

  }

}