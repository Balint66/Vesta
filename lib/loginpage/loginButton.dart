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

    if(!_loggingIn)
    {
      return MaterialButton(onPressed: LoginForm.of(context).ableToLogin
            ? () => setState(() {
                      _loggingIn = true;
                    }) : null,
          color: Theme.of(context).primaryColor,
          minWidth: 150.0,
          shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor, width:2.0), borderRadius: BorderRadius.circular(20.0)),
          child: Text(AppTranslations.of(context).translate('login_login_button'), maxLines: 1,),
      );
    }
    else
    {
      return FutureBuilder(future: WebServices.login(Data.username, Data.password, Data.school,
          Vesta.of(context).settings.stayLogged), builder: (BuildContext context, AsyncSnapshot snapshot)
          {
            if(!snapshot.hasData && !snapshot.hasError)
            {
              return CircularProgressIndicator();
            }
            if(snapshot.hasError)
            {
              Vesta.showSnackbar(Text(AppTranslations.of(context).translate('login_login_error')));
              Vesta.logger.e(snapshot.error);
            }

            setState(() {
                _loggingIn = false;
              });

            if(VestaRouter.mainKey.currentContext != null)
            {
              (VestaRouter.mainKey.currentState)?.refreshListHolders();
            }

            Navigator.pushReplacementNamed(context, '/app/home');
            return Container(width: 0.0,height: 0.0,);

          },);
    }

  }


}