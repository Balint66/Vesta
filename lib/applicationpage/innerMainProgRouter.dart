import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/applicationpage/messages/messageListDisplay.dart';
import 'package:vesta/routing/router.dart';

class MainProgRouter
{

  static final Router _mainProgRouter = new Router();

  static final List<UniqueKey> keys = List.of([new UniqueKey(), new UniqueKey()],growable: false);

  static void registerRoutes()
  {

    VestaRouter.router.define("/app/:inner", handler: _appNestedHandler);

    define("/messages", handler: _messageHandler);
    define("/calendar", handler: _calendarHandler);

  }

  static void define(String innerPath, {Handler handler})
  {
    _mainProgRouter.define("/app$innerPath", handler: handler);
  }

  static Route route(RouteSettings settings)
  {

    if(settings.name == "/app/home")
      settings = new RouteSettings(name: defaultRoute,
          arguments: settings.arguments);

    return _mainProgRouter.generator(settings);
  }

  static String defaultRoute = "/app/messages";
  static final MainProgram _mainProgram = new MainProgram(key:VestaRouter.mainKey);
  static final MessageListDisplay _messageListDisplay = MessageListDisplay(key: keys[0],);
  static final LessonDisplayer _lessonDisplayer = LessonDisplayer(key: keys[1]);

  static final Handler _messageHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _messageListDisplay;
  });

  static final Handler _calendarHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> querry)
  {
    return _lessonDisplayer;
  });

  static final Handler _appNestedHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, List<String>> query)
  {
    MainProgram main;

    if( VestaRouter.mainKey.currentWidget == null)
    {
      main = _mainProgram;
      main.createState();
    }
    else
      main = VestaRouter.mainKey.currentWidget;

    waitThenNavigate(query["inner"][0].toString());

    return main;
  });

  static void waitThenNavigate(String path) async
  {

    await Future.delayed(new Duration(microseconds: 1),() async => await Future.doWhile(() => MainProgram.navKey.currentState == null));

    //MainProgram.navKey.currentState.pushReplacementNamed(path);

  }
}