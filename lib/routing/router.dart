import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/loginpage/Authorization.dart';

class VestaRouter
{

  static Router router = new Router();

  static void registerRoutes()
  {

    router.define("/login", handler: _loginHandler);
    //router.define("/app", handler: _appHandler);

    MainProgram.registerRoutes();

  }

  static Handler _loginHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    return new Authorization();

  });

  static Handler _appHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return MainProgram(key: MainProgram.mainKey,);
  });

}