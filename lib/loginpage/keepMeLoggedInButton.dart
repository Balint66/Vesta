import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';

class KeepMeLoggedInButton extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _KeepMeLoggedInButtonState();
  }

}

class _KeepMeLoggedInButtonState extends State<KeepMeLoggedInButton>
{
  @override
  Widget build(BuildContext context)
  {

    return new Wrap(
      spacing: 10,
      children: <Widget>[
        new Checkbox(
            value: Vesta.of(context).settings.stayLogged,
            onChanged: (bool value)=> Vesta.of(context).updateSettings(keepMeLogged: value),
        ),
        new Container(
          padding: EdgeInsets.only(top: 15),
          child: new Text("Keep me logged in"),
        ),
      ],
    );

  }

}