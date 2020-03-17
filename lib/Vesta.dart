import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/settings/settingsData.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';


class Vesta extends StatefulWidget
{

  static final FlutterLocalNotificationsPlugin notificationPlugin = new FlutterLocalNotificationsPlugin();

  static final Logger logger = new Logger();

  static Function showSnackbar = (Widget widget)=>MessageManager.showSnackBar(widget);

  static String home = "/login";

  static Route<dynamic> generateRoutes(RouteSettings settings)
  {
    if(settings.name == "/home")
    {

      settings = new RouteSettings(name: home,
          //isInitialRoute: settings.isInitialRoute,
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
        this.data = data ,super(key: key, child: child);

  final VestaState data;

  @override
  bool updateShouldNotify(_VestaInherited oldWidget) {
    return true;
  }

}

class VestaState extends State<Vesta>
{

  @override
  void initState()
  {

    super.initState();
    initPlatform();

  }

  SettingsData _settings = new SettingsData();

  void updateSettings({Color mainColor, bool isDarkTheme})
  {
    if(mainColor == null && isDarkTheme == null)
      return;

    setState(() {
      if(mainColor != null)
        _settings.mainColor = mainColor;
      if(isDarkTheme != null)
        _settings.isDarkTheme = isDarkTheme;
      FileManager.saveSettings(_settings);
    });

  }

  SettingsData get settings => _settings;

  Future<void> initPlatform() async
  {
    BackgroundFetch.configure(BackgroundFetchConfig(
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
    if(!mounted)
      return;
  }

  @override
  Widget build(BuildContext context)
  {

    VestaRouter.registerRoutes();

    Future<bool> _post = Future.delayed(new Duration(milliseconds: 1),() async
    {

      _settings = await FileManager.loadSettings();

      return FileManager.readData();
    });

      return new FutureBuilder(future:_post,
          builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot)
          {

            if(!snapshot.hasData && !snapshot.hasError)
              return new CircularProgressIndicator();

            if(snapshot.hasError)
              Vesta.logger.e(snapshot.error);

            if(!snapshot.hasError && snapshot.data){
              Vesta.home = "/app/home";
              StudentData.Instance;
            }

           return new OverlaySupport(
              child: new _VestaInherited(
                data: this,
                child: new MaterialApp(
                  title: "Vesta",
                  theme: new ThemeData(
                        primarySwatch: settings.mainColor,
                        primaryColor: settings.mainColor,
                        accentColor: settings.mainColor,
                        brightness: settings.isDarkTheme ? Brightness.dark : Brightness.light,
                    ),
                    darkTheme: new ThemeData(
                      primarySwatch: settings.mainColor,
                      primaryColor: settings.mainColor,
                      accentColor: settings.mainColor,
                      brightness: settings.isDarkTheme ? Brightness.dark : Brightness.light,
                    ),
                    onGenerateRoute: Vesta.generateRoutes,
                    initialRoute: "/home",
                  )
                )
              )
          ;}
      );

  }

}