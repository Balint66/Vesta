import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/routing/replacementObserver.dart';

class MainProgram extends StatefulWidget
{

  MainProgram({Key key}) :super(key: key);

  static final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  static NavigatorState of(BuildContext context)
  {
    return context.findAncestorStateOfType<MainProgramState>()._parentNavigator;
  }

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {

    _parentNavigator = Navigator.of(context);

    final Navigator _navigator = new Navigator(
      key: MainProgram.navKey,
      onGenerateRoute: MainProgRouter.route,
      initialRoute: "${MainProgRouter.defaultRoute}",
      observers: [ReplacementObserver.Instance],
    );


    return Scaffold(
      key: widget._scaffoldKey,
      body: _navigator,
      appBar: AppBar(title: Text("Vesta"),actions: <Widget>[
        new IconButton(icon: new Icon(Icons.more_vert), onPressed: ()=> widget.
        _scaffoldKey.currentState.openEndDrawer())
      ],),
      drawer: Sidebar(key: widget.sidebarKey),
      endDrawer: new FlatButton.icon(onPressed: null, icon: new Icon(Icons.keyboard_arrow_down), label: new Text("Text"),),
    );
  }

}