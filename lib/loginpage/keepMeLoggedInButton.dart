import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';

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
            value: Vesta.of(context).settings.stayLogged,
            onChanged: (bool? value)=> Vesta.of(context).updateSettings(keepMeLogged: value),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text((AppTranslations.of(context)).translate('login_keepmeloggedin')),
        ),
      ],
    );

  }

}