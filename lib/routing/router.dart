import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/loginpage/Authorization.dart';
import 'package:vesta/settings/MainSettingsPage.dart';

class VestaRouter
{

  static final Router router = new Router();

  static final GlobalKey<MainProgramState> mainKey = new GlobalKey<MainProgramState>();

  static void registerRoutes()
  {

    router.define("/login", handler: _loginHandler);
    router.define("/settings", handler: _settingsHandler);

    MainProgRouter.registerRoutes();

  }

  static Handler _loginHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    return new Authorization();

  });

  static Handler _settingsHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return MainSettingsPage();
  });

}