import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/eulapage/Eulapage.dart';
import 'package:vesta/loginpage/Authorization.dart';
import 'package:vesta/settings/MainSettingsPage.dart';
import 'package:vesta/settings/pageSettingsBase.dart';

abstract class VestaRouter 
{

  factory VestaRouter()=>null;

  static final Router router = Router();

  static final mainKey = widgets.GlobalKey<MainProgramState>();

  static final _authorization = Authorization();
  static final _mainSettingsPage = MainSettingsPage();

  static void registerRoutes()
  {

    router.define('/login', handler: _loginHandler, transitionType: TransitionType.inFromRight);
    router.define('/settings/:type', handler: _settingsHandler, transitionType: TransitionType.inFromRight);
    router.define('/eula', handler: _eulaHandler, transitionType: TransitionType.inFromRight);
    router.define('/pageSettings/:page', handler: _pageSettingsHandler, transitionType: TransitionType.inFromRight);


    MainProgRouter.registerRoutes();

  }

  static final _loginHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String, dynamic> query)
  {

    return _authorization;

  });

  static final _settingsHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String, dynamic> query)
  {
    switch(query['type'][0]?.toString())
    {
      case 'main':
      default:
        return _mainSettingsPage;
    }
  });

  static final _eulaHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String,dynamic> query)
  {
    return Eula();
  });

  static final _pageSettingsHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String,dynamic> query)
  {
    var str = query['page'][0].toString();
    return PageSettingsBase(str, Vesta.of(ctx).settings.pageSettings[str]);
  });

}