import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/datastorage/Lists/holder/listHolder.dart';
import 'package:vesta/applicationpage/popupSettings.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/routing/replacementObserver.dart';
import 'package:vesta/web/fetchManager.dart';

class MainProgram extends StatefulWidget
{

  final String startingRoute;

  MainProgram({Key key, String route}) : this.startingRoute = route == null || route.isEmpty ? MainProgRouter.defaultRoute : route, super(key: key)
  {
    if(ReplacementObserver.Instance != null && (route != null && route.isNotEmpty))
      ReplacementObserver.Instance.currentPath = route;
  }

  static final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

  final UniqueKey sidebarKey = new UniqueKey();

  @override
  State<StatefulWidget> createState()
  {
    return MainProgramState();
  }

  static MainProgramState of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<_MainProgramInherited>().data;
  }


}

class MainProgramState extends State<MainProgram>
{

  static final GlobalKey<PopupSettingsState> _popupSettingsKey = new GlobalKey<PopupSettingsState>();

  NavigatorState _parentNavigator;
  NavigatorState get parentNavigator => _parentNavigator;

  CalendarListHolder _calendarList = new CalendarListHolder();
  CalendarListHolder get calendarList => _calendarList;

  MessageListHolder _messageList = new MessageListHolder();
  MessageListHolder get messageList => _messageList;

  StudentBookListHolder _studentBook = new StudentBookListHolder();
  StudentBookListHolder get studentBook => _studentBook;

  SemesterListHolder _semesterList = new SemesterListHolder();
  SemesterListHolder get semesterList => _semesterList;

  SubjectDataListHolder _subjectList = new SubjectDataListHolder();
  SubjectDataListHolder get subject => _subjectList;
  
  void refreshListHolders()
  {

    setState(() {
    FetchManager.clearRegistered();

    _calendarList = new CalendarListHolder();
    _messageList = new MessageListHolder();
    _studentBook = new StudentBookListHolder();
    _semesterList = new SemesterListHolder();
    _subjectList = new SubjectDataListHolder();
    
    FetchManager.register(_calendarList);
    FetchManager.register(_messageList);
    FetchManager.register(_studentBook);
    FetchManager.register(_semesterList);
    FetchManager.register(_subjectList);
    
    }
    );

  }

  @override
  void initState()
  {

    super.initState();

    FetchManager.register(_calendarList);
    FetchManager.register(_messageList);
    FetchManager.register(_studentBook);
    FetchManager.register(_semesterList);
    FetchManager.register(_subjectList);

  }

  final PopupSettings _popupSettings = new PopupSettings(key: _popupSettingsKey);

  @override
  Widget build(BuildContext context)
  {

    MainProgRouter.defaultRoute = "/app"+Vesta.of(context).settings.appHomePage;

    _parentNavigator = Navigator.of(context);

    final Navigator _navigator = new Navigator(
      key: MainProgram.navKey,
      onGenerateRoute: MainProgRouter.route,
      initialRoute: "${widget.startingRoute}",
      observers: [ReplacementObserver.Instance],
    );

    return new PopupOptionProviderWidget(data: ()=> _popupSettingsKey.currentState, child: new _MainProgramInherited(data: this,
      child: new Scaffold(
        body: _navigator,
        appBar: AppBar(title: Text("Vesta"),
          actions: <Widget>[
                _popupSettings
        ],),
        drawer: Sidebar(key: widget.sidebarKey),
      ),
    ));
  }

}

class _MainProgramInherited extends InheritedWidget
{

  final MainProgramState data;

  _MainProgramInherited({Key key, @required Widget child, @required MainProgramState data}) :
        this.data = data ,super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)
  {
    return true;  
  }
  
}