import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/acountData.dart';

class AccountDisplayer extends StatelessWidget
{
  final AccountData data;
  AccountDisplayer(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(3.5, 14.0, 3.5, 3.5),
      child: ListTile(
        title: Text(data.training.code),
        subtitle: Text(data.training.description),
        trailing: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(color: data.color, shape: BoxShape.circle),
          child: Text(data.username[0], style: TextStyle(fontSize: 20),)
        ),
      )
    );
  }
}