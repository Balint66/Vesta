import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/routing/router.dart';
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

}

class VestaState extends State<Vesta>
{

  @override
  void initState()
  {

    super.initState();
    initPlatform();

  }

  Future<void> initPlatform() async
  {
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,
      requiredNetworkType: NetworkType.ANY,
    ), (String TaskID) async
    {
      await FetchManager.fetch();
      BackgroundFetch.finish(TaskID);
    });
    if(!mounted)
      return;
  }

  @override
  Widget build(BuildContext context)
  {

    VestaRouter.registerRoutes();

      return new FutureBuilder(future: FileManager.readData(),
          builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot)
          {

            if(!snapshot.hasData && !snapshot.hasError)
              return new CircularProgressIndicator();

            if(snapshot.hasError)
              Vesta.logger.e(snapshot.error);

            if(!snapshot.hasError && snapshot.data)
              Vesta.home = "/app/home";

           return new OverlaySupport(
              child: new MaterialApp(
                title: "Vesta",
                theme: ThemeData(primarySwatch: Colors.red),
                onGenerateRoute: Vesta.generateRoutes,
                initialRoute: "/home",
              )
          )
           ;}
      );

  }

}