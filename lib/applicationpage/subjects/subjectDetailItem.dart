import 'package:flutter/material.dart';

class SubjectDetailItem extends StatelessWidget
{

  final String category;
  final String item;

  SubjectDetailItem(String itemCategory, String item) : this.category = itemCategory, this.item = item;

  @override
  Widget build(BuildContext context) {
    

    return new Container(
      child: new Column(
        children: [
          new Text(category, style: new TextStyle(color: Colors.grey, fontSize: 10)),
          new Text(item)
        ],
      ),
      padding: EdgeInsets.all(4),
    );

  }

}