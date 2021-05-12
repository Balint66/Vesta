import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/loginpage/loginForm.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

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
      return FutureBuilder(future:(() async 
        {

          SimpleConatiner? cont;

          try{
          cont = await WebServices.login(LoginForm.of(context).userName, LoginForm.of(context).password, Data.school,
          Vesta.of(context).settings.stayLogged);
          }
          catch(e)
          {
            Vesta.showSnackbar(Text(AppTranslations.of(context).translate('login_login_error')));
            rethrow;
          }
          Future.delayed(Duration(seconds:2),()=>setState(() {
            _loggingIn = false;
            Navigator.pushReplacementNamed(context, '/app/home');
          }));
          return cont;
        })(),
          builder: (BuildContext context, AsyncSnapshot snapshot)
          {
            if(!snapshot.hasData && !snapshot.hasError)
            {
              return CircularProgressIndicator();
            }
            if(snapshot.hasError)
            {
              Vesta.logger.e(snapshot.error);
            }

            if(VestaRouter.mainKey.currentContext != null)
            {
              AccountManager.currentAccount.refreshListHolders();
            }

            return Container(width: 0.0,height: 0.0,);

          },);
    }

  }


}