import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/eulapage/Eulapage.dart';
import 'package:vesta/loginpage/Authorization.dart';
import 'package:vesta/settings/MainSettingsPage.dart';
import 'package:vesta/settings/aboutpage.dart';
import 'package:vesta/settings/advancedSettings.dart';
import 'package:vesta/settings/commonPageSettings.dart';
import 'package:vesta/settings/pageSettingsBase.dart';
import 'package:vesta/settings/schoolSettings.dart';
import 'package:vesta/settings/uiSettings.dart';

abstract class VestaRouter 
{

  static final router = FluroRouter();

  static final mainKey = widgets.GlobalKey<MainProgramState>();

  static final _authorization = Authorization();
  static final _mainSettingsPage = MainSettingsPage();
  static final _uiSettingsPage = UISettings();
  static final _advancedSettingsPage = AdvancedSettings();
  static final _commonPageSettings = CommonPageSettings();
  static final _schoolSettingsPage = SchoolSettings();
  static final _aboutSettingsPage = AboutPage();

  static void registerRoutes()
  {

    router.define('/login', handler: _loginHandler, transitionType: TransitionType.inFromRight);
    router.define('/settings/:type', handler: _settingsHandler, transitionType: TransitionType.inFromRight);
    router.define('/eula', handler: _eulaHandler, transitionType: TransitionType.inFromRight);
    router.define('/pageSettings/:page', handler: _pageSettingsHandler, transitionType: TransitionType.inFromRight);


    MainProgRouter.registerRoutes();

  }

  static final _loginHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String, List<String>>? query)
  {

    return _authorization;

  }as HandlerFunc);

  static final _settingsHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String, List<String>>? query)
  {
    switch(query?['type']?[0])
    {
      case 'about':
        return _aboutSettingsPage;
      case 'school':
        return _schoolSettingsPage;
      case 'page':
        return _commonPageSettings;
      case 'advanced':
        return _advancedSettingsPage;
      case 'ui':
        return _uiSettingsPage;
      case 'main':
      default:
        return _mainSettingsPage;
    }
  } as HandlerFunc);

  static final _eulaHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String,List<String>>? query)
  {
    return Eula();
  } as HandlerFunc);

  static final _pageSettingsHandler = Handler(handlerFunc: (widgets.BuildContext ctx, Map<String,List<String>>? query)
  {
    var str = query!['page']![0].toString();
    return PageSettingsBase(str, Vesta.of(ctx).settings.pageSettings[str]);
  } as HandlerFunc);

}