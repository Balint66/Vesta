import 'package:flutter/material.dart';

class SubjectDetailItem extends StatelessWidget
{

  final String category;
  final String item;

  SubjectDetailItem(String itemCategory, String item) : category = itemCategory, item = item;

  @override
  Widget build(BuildContext context) {
    

    return Container(
      child: Column(
        children: [
          Text(category, style: TextStyle(color: Colors.grey, fontSize: 10)),
          Text(item)
        ],
      ),
      padding: EdgeInsets.all(4),
    );

  }

}