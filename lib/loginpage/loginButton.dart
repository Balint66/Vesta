
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/web/webServices.dart';

class LoginButton extends StatefulWidget
{

  final LoginBtnState state = new LoginBtnState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

}

class LoginBtnState extends State<LoginButton>
{


  bool _loggingIn=false;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    return Stack(children: <Widget>[
      button(),
      loading(),
    ],);

  }

  Future<void> startLogin() async
  {

    setState(() {
      _loggingIn = true;
    });

    try
    {

      var res = await WebServices.login(Data.username, Data.password, Data.school);

      setState(() {
        _loggingIn = false;
      });

      //MessageManager.showToast("Hola!");

      if(res)
      {

        var home = "home";

        Navigator.pushReplacementNamed(context, "/app/$home");
        return;
      }


      Vesta.showSnackbar(new Text("Unable to login"));

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
    if(_loggingIn)
      return CircularProgressIndicator();
    return Container(width: 0.0,height: 0.0,);
  }

  Widget button()
  {
    if(!_loggingIn)
      return new MaterialButton(onPressed: ()=>startLogin(),
          child: Text("Login",maxLines: 1,),
          color: Colors.red,
          minWidth: 150.0);
    return Container(width: 0.0,height: 0.0,);
  }


}