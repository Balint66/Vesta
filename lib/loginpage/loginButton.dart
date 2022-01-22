import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'login.i18n.dart';
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
          child: Text('login'.i18n, maxLines: 1,),
      );
    }
    else
    {
      return FutureBuilder(future:(() async 
        {

          SimpleConatiner? cont;

          try
          {
            cont = await WebServices.login(LoginForm.of(context).userName, LoginForm.of(context).password, Data.school,
            SettingsManager.INSTANCE.settings.stayLogged);
            Future.delayed(Duration(seconds:2),()=>setState(() {
              _loggingIn = false;
              if(cont != null)
              {
                (Router.of(context).routerDelegate as MainDelegate).SetPath('/app/home');
              }
            }));
            
          }
          catch(e)
          {
            Vesta.showSnackbar(Text('login_error'.i18n));
            rethrow;
          }
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
              Vesta.logger.e('LET ME IIIN!', snapshot.error);
            }

            if(MainDelegate.mainKey.currentContext != null)
            {
              AccountManager.currentAccount.refreshListHolders();
            }

            return Container(width: 0.0,height: 0.0,);

          },);
    }

  }


}