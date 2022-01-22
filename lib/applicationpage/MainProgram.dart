import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/settings/pageSettingsData.dart';

class MainProgram extends StatefulWidget
{

  final AppPath startingRoute;
  final Map<String, PageSettingsData> baseSettings;

  MainProgram({Key? key, required AppPath route, Map<String, PageSettingsData>? baseSettings}) 
  : startingRoute = route, baseSettings = baseSettings ?? {}, super(key: key);

  static final GlobalKey<State<Router>> routerKey = GlobalKey<State<Router>>();

  final UniqueKey sidebarKey = UniqueKey();

  @override
  State<StatefulWidget> createState()
  {
    return MainProgramState();
  }

  static MainProgramState of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<_MainProgramInherited>()!.data;
  }


}

class MainProgramState extends State<MainProgram>
{

  late NavigatorState _parentNavigator;
  NavigatorState get parentNavigator => _parentNavigator;


  void makeRefresh()
  {
    if(Vesta.of(context).pageSettingsChanged)
    {
      Vesta.of(context).resetpageChange();
      setState(() {
      AccountManager.currentAccount.refreshListHolders();});
    }
  }

  void Reload() => setState((){});

  AppPath _getPath(){
    return widget.startingRoute;
  }

  var _delegate;


  @override
  void initState() {
    super.initState();
    _delegate = AppDelegate(_getPath);
  }


 // final PopupSettings _popupSettings = PopupSettings(key: _popupSettingsKey);

  @override
  Widget build(BuildContext context)
  {
    
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { makeRefresh(); });

    MainProgRouter.defaultRoute = '/app'+SettingsManager.INSTANCE.settings.appHomePage;

    _parentNavigator = Navigator.of(context);

    final _router = Router(
      key: MainProgram.routerKey,
      routerDelegate: _delegate,
    );

    return _MainProgramInherited(data: this,
      child: Scaffold(
        body: _router,
        appBar: AppBar(title: Text('Vesta'),
          actions: <Widget>[
                IconButton(icon: Icon(Icons.settings), onPressed: (){
                  /*Navigator.of(context).pushNamed('/pageSettings/' 
                  + ReplacementObserver.Instance.currentPath.split('/')[2]);*/
                  }),
        ],),
        drawer: Sidebar(key: widget.sidebarKey),
      ),
    );
  }

}

class _MainProgramInherited extends InheritedWidget
{

  final MainProgramState data;

  _MainProgramInherited({Key? key, @required Widget? child, @required MainProgramState? data}) :
        data = data! ,super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)
  {
    return true;  
  }
  
}