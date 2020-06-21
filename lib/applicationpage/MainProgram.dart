import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/datastorage/Lists/holder/listHolder.dart';
import 'package:vesta/applicationpage/popupSettings.dart';
import 'package:vesta/applicationpage/sidebar.dart';
import 'package:vesta/routing/replacementObserver.dart';
import 'package:vesta/web/fetchManager.dart';

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
  
  static MainProgramState of(BuildContext context)
  {
    return context.findAncestorStateOfType<MainProgramState>();
  }

  void refreshListHolders()
  {

    setState(() {
    FetchManager.clearRegistered();

    _calendarList = new CalendarListHolder();
    _messageList = new MessageListHolder();
    _studentBook = new StudentBookListHolder();
    _semesterList = new SemesterListHolder();
    _subjectList = new SubjectDataListHolder();}
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