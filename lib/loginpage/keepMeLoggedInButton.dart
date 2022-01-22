import 'package:flutter/material.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'login.i18n.dart';

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

    return Wrap(
      spacing: 5,
      children: <Widget>[
        Checkbox(
            value: SettingsManager.INSTANCE.settings.stayLogged,
            onChanged: (bool? value)=> SettingsManager.INSTANCE.updateSettings(keepMeLogged: value),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text('keepmeloggedin'.i18n),
        ),
      ],
    );

  }

}