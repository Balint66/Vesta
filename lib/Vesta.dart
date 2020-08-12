import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:universal_io/prefer_universal/io.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/i18n/localizedApp.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/settings/settingsData.dart';
import 'package:vesta/utils/ColorUtils.dart';
import 'package:vesta/utils/ColoredThemeData.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:intl/intl.dart';


class Vesta extends StatefulWidget
{
  
  static var home = '/login';
  
  static final logger = Logger();
  static final showSnackbar = (Widget widget)=>MessageManager.showSnackBar(widget);
  static final dateFormatter = DateFormat('yy. MM. dd. HH:mm');

  static Route<dynamic> generateRoutes(RouteSettings settings)
  {
    if(settings.name == '/home')
    {

      settings = RouteSettings(name: home,
          arguments: settings.arguments);

    }

    return VestaRouter.router.generator(settings);
  }

  @override
  State<StatefulWidget> createState()
  {
    return VestaState();
  }

  static VestaState of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<_VestaInherited>().data;
  }

}

class _VestaInherited extends InheritedWidget
{

  _VestaInherited({Key key, @required Widget child, @required VestaState data}) :
        data = data ,super(key: key, child: child);

  final VestaState data;

  @override
  bool updateShouldNotify(_VestaInherited oldWidget) {
    return true;
  }

}

class VestaState extends State<Vesta> with WidgetsBindingObserver
{

  @override
  void initState()
  {

    super.initState();
    application.addListener(onLocaleChanged);
    initPlatform();
    _post = Future.delayed(Duration(milliseconds: 1),() async
    {

      var newSettings = await FileManager.loadSettings();
      if(newSettings != null) {
        _settings = newSettings;
      }
      
        application.changeLocal(application.supportedLocales().where((element) => element.languageCode == _settings.language).first);

      return FileManager.readData();
    });

    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose()
  {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) 
  {
    super.didChangeAppLifecycleState(state);

    switch(state)
    {
      case AppLifecycleState.paused:
        FetchManager.stopFrontFetch();
        break;
      case AppLifecycleState.resumed:
        FetchManager.startFrontFetch();
        break;
      default:
        return;
    }

  }

  void onLocaleChanged()
  {
    setState(() {
      AppTranslations.load(application.appDelegate.newLocale);
    });
  }

  var _settings = SettingsData();

  void resetSettings()
  {

    setState(()
    {
      _settings = SettingsData();
    });

  }

  void updateSettings({Color mainColor, bool isDarkTheme, bool keepMeLogged,
    String route, bool eulaWasAccepted, String language, bool devMode})
  {
    if(mainColor == null && isDarkTheme == null && keepMeLogged == null
        && route == null && eulaWasAccepted == null && language == null && devMode == null) {
      return;
    }

    setState(() {
      if(mainColor != null) {
        _settings.mainColor = mainColor;
      }
      if(isDarkTheme != null) {
        _settings.isDarkTheme = isDarkTheme;
      }
      if(keepMeLogged != null) {
        _settings.stayLogged = keepMeLogged;
      }
      if(eulaWasAccepted != null) {
        _settings.eulaAccepted = eulaWasAccepted;
      }
      if(route!= null)
      {
        _settings.appHomePage = '/' + route.split('/')[2];
        MainProgRouter.defaultRoute = route;
      }
      if(language != null){
        _settings.language = language;
      }
      if(devMode != null){
        _settings.devMode = devMode;
      }
      FileManager.saveSettings(_settings);
    });

  }

  SettingsData get settings => SettingsData.copyOf(_settings);

  Future<void> initPlatform() async
  {
    try
    {
      if( Platform.isAndroid || Platform.isIOS) {
        await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiredNetworkType: NetworkType.ANY,
      ), (String id) async
      {
        await FetchManager.fetch();
        BackgroundFetch.finish(id);
      });
      }
    }
    catch(e)
    {
      Vesta.logger.w('Dabiri-dabirido! What does this button do?\n Unable to configure background fetch. Something is not implemented? \n error:$e');
    }
  }

  Future<bool> _post;

  @override
  Widget build(BuildContext context)
  {

    VestaRouter.registerRoutes();

    FetchManager.init();

      return FutureBuilder(future:_post,
          builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot)
          {

            if(!snapshot.hasData && !snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasError && !(snapshot.error is MissingPluginException)) {
              Vesta.logger.e(snapshot.error);
            }

            if(!snapshot.hasError && snapshot.data){
              Vesta.home = '/app/home';
              StudentData.Instance;
            }

           return OverlaySupport(
              child: _VestaInherited(
                data: this,
                child: MaterialApp(
                  title: 'Vesta',
                  theme: ColoredThemeData.create(
                        primarySwatch: MaterialColor(settings.mainColor.value, genSwatch()),
                        brightness: Brightness.light,
                    ),
                    darkTheme: ColoredThemeData.create(
                      primarySwatch: MaterialColor(settings.mainColor.value, genSwatch()),
                      brightness: Brightness.dark,
                    ),
                    onGenerateRoute: Vesta.generateRoutes,
                    initialRoute: _settings.eulaAccepted ? '/home' : '/eula',
                    localizationsDelegates: 
                    [
                      application.appDelegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    supportedLocales: [
                      Locale('en'),
                      Locale('hu')
                    ],
                    themeMode: _settings.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
                  )
                )
              )
          ;}
      );

  }

  Map<int, Color> genSwatch()
  {
      var stringSwatch = ColorUtils.swatchColor(ColorUtils.intToHex(settings.mainColor.value));

      var map = <int, Color>{};

      for(var i = 0; i < stringSwatch.length; i++)
      {
        if(i == 0)
        {
          map.putIfAbsent(50, () => Color(ColorUtils.hexToInt(stringSwatch[i])));
        }
        else
        {
          map.putIfAbsent(100 * i, () => Color(ColorUtils.hexToInt(stringSwatch[i])));
        }
      }

      return map;

  }

}