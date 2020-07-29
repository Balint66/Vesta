import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/eulapage/Eulapage.dart';
import 'package:vesta/loginpage/Authorization.dart';
import 'package:vesta/settings/MainSettingsPage.dart';

abstract class VestaRouter 
{

  factory VestaRouter()=>null;

  static final Router router = Router();

  static final mainKey = GlobalKey<MainProgramState>();

  static final _authorization = Authorization();
  static final _mainSettingsPage = MainSettingsPage();

  static void registerRoutes()
  {

    router.define('/login', handler: _loginHandler);
    router.define('/settings', handler: _settingsHandler);
    router.define('/eula', handler: _eulaHandler);

    MainProgRouter.registerRoutes();

  }

  static final _loginHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    return _authorization;

  });

  static final _settingsHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _mainSettingsPage;
  });

  static final _eulaHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> query)
  {
    return Eula();
  });

}