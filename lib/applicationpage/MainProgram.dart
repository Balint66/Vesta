import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/applicationpage/popupSettings.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/routing/replacementObserver.dart';

class MainProgram extends StatefulWidget
{

  MainProgram({Key key}) :super(key: key);

  static final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

  final UniqueKey sidebarKey = new UniqueKey();

  @override
  State<StatefulWidget> createState()
  {
    return MainProgramState();
  }
}

class MainProgramState extends State<MainProgram>
{

  NavigatorState _parentNavigator;
  NavigatorState get parentNavigator => _parentNavigator;
  
  static MainProgramState of(BuildContext context)
  {
    return context.findAncestorStateOfType<MainProgramState>();
  }

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    MainProgRouter.defaultRoute = "/app"+Vesta.of(context).settings.appHomePage;

    _parentNavigator = Navigator.of(context);

    final Navigator _navigator = new Navigator(
      key: MainProgram.navKey,
      onGenerateRoute: MainProgRouter.route,
      initialRoute: "${MainProgRouter.defaultRoute}",
      observers: [ReplacementObserver.Instance],
    );

    return Scaffold(
      body: _navigator,
      appBar: AppBar(title: Text("Vesta"),
        actions: <Widget>[
              new PopupSettings()
      ],),
      drawer: Sidebar(key: widget.sidebarKey),
    );
  }

}