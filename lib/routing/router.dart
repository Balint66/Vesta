import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/eulapage/Eulapage.dart';
import 'package:vesta/loginpage/Authorization.dart';
import 'package:vesta/settings/MainSettingsPage.dart';

class VestaRouter
{

  static final Router router = new Router();

  static final GlobalKey<MainProgramState> mainKey = new GlobalKey<MainProgramState>();

  static final Authorization _authorization = new Authorization();
  static final MainSettingsPage _mainSettingsPage = new MainSettingsPage();

  static void registerRoutes()
  {

    router.define("/login", handler: _loginHandler);
    router.define("/settings", handler: _settingsHandler);
    router.define("/eula", handler: _eulaHandler);

    MainProgRouter.registerRoutes();

  }

  static Handler _loginHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    return _authorization;

  });

  static Handler _settingsHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _mainSettingsPage;
  });

  static Handler _eulaHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> query)
  {
    return new Eula();
  });

}