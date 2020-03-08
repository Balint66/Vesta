import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/messageListDisplay.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/routing/replacementObserver.dart';
import 'package:vesta/routing/router.dart';

final ReplacementObserver observer = new ReplacementObserver();

class MainProgram extends StatefulWidget
{

  MainProgram({Key key}) :super(key: key);

  static final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();
  static final GlobalKey<MainProgramState> mainKey = new GlobalKey<MainProgramState>();

  static final Router _mainProgRouter = new Router();

  static void registerRoutes()
  {

    VestaRouter.router.define("/app/:inner", handler: _appNestedHandler);

    define("/messages", handler: _messageHandler);

  }

  static void define(String innerPath, {Handler handler})
  {
    _mainProgRouter.define("/app$innerPath", handler: handler);
  }

  static Route route(RouteSettings settings)
  {

    if(settings.name == "/app/home")
      settings = new RouteSettings(name: defaultRoute,
          //isInitialRoute: settings.isInitialRoute,
          arguments: settings.arguments);

    return _mainProgRouter.generator(settings);
  }

  static String defaultRoute = "/app/messages";

  static final Handler _messageHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return MessageListDisplay();
  });

  static final Handler _appNestedHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, List<String>> query)
  {
    MainProgram main;

    if(mainKey.currentWidget == null)
    {
      main = new MainProgram(key:mainKey);
      main.createState();
    }
    else
      main = mainKey.currentWidget;

    waitThenNavigate(query["inner"][0].toString());

    return main;
  });

   static void waitThenNavigate(String path) async
  {

    while(navKey.currentState == null);

    navKey.currentState.pushReplacementNamed(path);

  }

  @override
  State<StatefulWidget> createState()
  {
    return MainProgramState();
  }
}

class MainProgramState extends State<MainProgram>
{

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    final Navigator _navigator = new Navigator(
      key: MainProgram.navKey,
      onGenerateRoute: MainProgram.route,
      initialRoute: "/app/home",
      observers: [observer],
    );


    return Scaffold(
      body: _navigator,
      appBar: AppBar(title: Text("Vesta")),
      drawer: Sidebar(),
      //endDrawer: null, TODO: create rightSideBar
    );
  }

}