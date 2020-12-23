import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/datastorage/Lists/holder/listDataHolder.dart';
import 'package:vesta/applicationpage/popupSettings.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/routing/replacementObserver.dart';
import 'package:vesta/settings/pageSettingsData.dart';
import 'package:vesta/web/fetchManager.dart';

class MainProgram extends StatefulWidget
{

  final String startingRoute;
  final Map<String, PageSettingsData> baseSettings;

  MainProgram({Key? key, String? route, Map<String, PageSettingsData>? baseSettings}) 
  : startingRoute = route == null || route.isEmpty ? MainProgRouter.defaultRoute : route, baseSettings = baseSettings ?? {}, super(key: key)
  {
    if(ReplacementObserver.Instance.currentPath.isEmpty && (route != null && route.isNotEmpty)) {
      ReplacementObserver.Instance.currentPath = route;
    }
  }

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

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

  static final _popupSettingsKey = GlobalKey<PopupSettingsState>();

  NavigatorState? _parentNavigator;
  NavigatorState? get parentNavigator => _parentNavigator;

  var _calendarList = CalendarListHolder();
  CalendarListHolder get calendarList => _calendarList;

  var _messageList;
  MessageListHolder get messageList => _messageList;

  var _studentBook = StudentBookListHolder();
  StudentBookListHolder get studentBook => _studentBook;

  var _semesterList = SemesterListHolder();
  SemesterListHolder get semesterList => _semesterList;

  var _subjectList = SubjectDataListHolder();
  SubjectDataListHolder get subject => _subjectList;
  
  void refreshListHolders()
  {

    setState(() {
        FetchManager.clearRegistered();

        _calendarList = CalendarListHolder();
        _messageList = MessageListHolder(timespan: Vesta.of(context).settings.pageSettings['messages']!.interval);
        _studentBook = StudentBookListHolder();
        _semesterList = SemesterListHolder();
        _subjectList = SubjectDataListHolder();
    
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

    _messageList = MessageListHolder(timespan: widget.baseSettings['messages']?.interval);

    FetchManager.register(_calendarList);
    FetchManager.register(_messageList);
    FetchManager.register(_studentBook);
    FetchManager.register(_semesterList);
    FetchManager.register(_subjectList);

  }

  void makeRefresh()
  {
    if(Vesta.of(context).pageSettingsChanged)
    {
      Vesta.of(context).resetpageChange();
      refreshListHolders();
    }
  }

 // final PopupSettings _popupSettings = PopupSettings(key: _popupSettingsKey);

  @override
  Widget build(BuildContext context)
  {
    
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { makeRefresh(); });

    MainProgRouter.defaultRoute = '/app'+Vesta.of(context).settings.appHomePage;

    _parentNavigator = Navigator.of(context);

    final _navigator = Navigator(
      key: MainProgram.navKey,
      onGenerateRoute: MainProgRouter.route,
      initialRoute: ReplacementObserver.Instance.currentPath.isEmpty ? widget.startingRoute : ReplacementObserver.Instance.currentPath,
      observers: [ReplacementObserver.Instance],
    );

    return PopupOptionProviderWidget(data: ()=> _popupSettingsKey.currentState!, child: _MainProgramInherited(data: this,
      child: Scaffold(
        body: _navigator,
        appBar: AppBar(title: Text('Vesta'),
          actions: <Widget>[
                IconButton(icon: Icon(Icons.settings), onPressed: (){
                  Navigator.of(context).pushNamed('/pageSettings/' 
                  + ReplacementObserver.Instance.currentPath.split('/')[2]);
                  }),
        ],),
        drawer: Sidebar(key: widget.sidebarKey),
      ),
    ));
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