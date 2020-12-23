
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/loginpage/loginForm.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/web/webServices.dart';

class LoginButton extends StatefulWidget
{

  final LoginBtnState state = LoginBtnState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

}

class LoginBtnState extends State<LoginButton>
{


  bool _loggingIn=false;

  @override
  Widget build(BuildContext context)
  {

    return Stack(children: <Widget>[
      button(context),
      loading(),
    ],);

  }

  Future<void> startLogin(BuildContext context) async
  {

    setState(() {
      _loggingIn = true;
    });

    try
    {

      var res = await WebServices.login(Data.username, Data.password, Data.school,
          Vesta.of(context).settings.stayLogged);

      setState(() {
        _loggingIn = false;
      });

      if(res)
      {

        if(VestaRouter.mainKey.currentContext != null)
        {
          (VestaRouter.mainKey.currentState)?.refreshListHolders();
        }

        await Navigator.pushReplacementNamed(context, '/app/home');
        return;
      }


      Vesta.showSnackbar(Text(AppTranslations.of(context).translate('login_login_error')));

    }
    catch(e)
    {
      setState(() {
        _loggingIn = false;
      });
      Vesta.logger.e(e);
    }

  }

  Widget loading()
  {
    if(_loggingIn) {
      return CircularProgressIndicator();
    }
    return Container(width: 0.0,height: 0.0,);
  }

  Widget button(BuildContext context)
  {
    if(!_loggingIn) {
      return MaterialButton(onPressed: LoginForm.of(context).ableToLogin
            ? () => startLogin(context) : null,
          child: Text(AppTranslations.of(context).translate('login_login_button'), maxLines: 1,),
          color: Theme.of(context).primaryColor,
          minWidth: 150.0,
      );
    }
    return Container(width: 0.0,height: 0.0,);
  }


}