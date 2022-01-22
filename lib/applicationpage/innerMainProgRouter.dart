import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/exams/examListDisplay.dart';
import 'package:vesta/applicationpage/forums/forums.dart';
import 'package:vesta/applicationpage/calendar/calendarDataDisplay.dart';
import 'package:vesta/applicationpage/messages/messageListDisplay.dart';
import 'package:vesta/applicationpage/semesters/semesterDisplayer.dart';
import 'package:vesta/applicationpage/studentBook/studentBookDisplay.dart';
import 'package:vesta/applicationpage/subjects/subjectsDisplayer.dart';
import 'package:vesta/routing/replacementObserver.dart';
import 'package:vesta/routing/router.dart';

class MainProgRouter
{

  static final List<UniqueKey> keys = List.of([UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey()],growable: false);

  static String defaultRoute = '/app/messages';

  static final MessageListDisplay _messageListDisplay = MessageListDisplay(key: keys[0],);
  static final LessonDisplayer _lessonDisplayer = LessonDisplayer(key: keys[1]);
  static final StudentBookDisplay _studentBookDisplayer = StudentBookDisplay(key: keys[2]);
  static final SemesterDisplayer _semesterInfoDisplayer = SemesterDisplayer(key: keys[3]);
  static final SubjectDisplayer _subjectInfoDisplayer = SubjectDisplayer(key: keys[4]);
  static final ExamListDisplay _examDisplay = ExamListDisplay(key: keys[5]);
  static final Forums _forums = Forums(key: keys[6]);

  /*static void registerRoutes()
  {

    VestaRouter.router.define('/app/:inner', handler: _appNestedHandler, transitionType: TransitionType.cupertino );

    define('/messages', handler: _messageHandler);
    define('/calendar', handler: _calendarHandler);
    define('/student_book', handler: _studentBookHandler);
    define('/semesters', handler: _semesterInfoHandler);
    define('/subjects', handler: _subjectHandler);
    define('/exams', handler: _examsHandler);
    define('/forums', handler: _forumHandler);

  }

  static void define(String innerPath, {@required Handler? handler, TransitionType transitionType = TransitionType.cupertinoFullScreenDialog})
  {
    _mainProgRouter.define('/app$innerPath', handler: handler, transitionType: transitionType);
  }

  static Route? route(RouteSettings settings)
  {
    return _mainProgRouter.generator(settings);
  }


  static final Handler _messageHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String, List<String>>? query)
  {
    return _messageListDisplay;
  });

  static final Handler _calendarHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String, dynamic> query)
  {
    return _lessonDisplayer;
  });

  static final Handler _studentBookHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String,dynamic> query)
  {
    return _studentBookDisplayer;
  });

  static final Handler _semesterInfoHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String,dynamic> query)
  {
    return _semesterInfoDisplayer;
  });

  static final Handler _subjectHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String,dynamic> query)
  {  
    return _subjectInfoDisplayer;
  });

  static final Handler _examsHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String,dynamic> query){
    return _examDisplay;
  });

  static final Handler _forumHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String, dynamic> query)
  {
    return _forums;
  });

  static final Handler _appNestedHandler = Handler(handlerFunc: (BuildContext? ctx, Map<String, dynamic> query)
  {

    String? path = query['inner']?[0];

    if(path == 'home' || path == null || path.isEmpty) {
      path = defaultRoute;
    }

    return MainProgram(key:VestaRouter.mainKey, route: path,);
  });*/

  /*static Widget _wrapinFutureBuilder(BuildContext ctx ,Widget child, PopupMenuItemBuilder<int> builder, PopupMenuItemSelected<int> selector)
  {
    return FutureBuilder(future: () async
    {
      PopupOptionProvider prov;
      var func = PopupOptionProviderWidget.of(ctx, rebuild: false);

      await Future.doWhile(() async
      {
        prov = func();

        if(prov == null)
        {
          await Future.delayed(Duration(seconds: 5));
          return true;
        }

        return false;

      });

      prov.setOptions(builder, selector);

      return true;


    }(), builder: (ctx, snap)
    {
      if(snap.hasData) {
        return child;
      }
      return Center(child: CircularProgressIndicator());
    });
  }*/
}

typedef _pathGetter = AppPath Function();

class AppDelegate extends RouterDelegate<AppPath>
  with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPath>
{

  final _pathGetter stateGetterFn;

  AppDelegate(this.stateGetterFn);

  @override
  Widget build(BuildContext context)
  {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child:_getWidget(stateGetterFn()), name: stateGetterFn().innerPath)
      ],
      onPopPage: (route, result) => route.didPop(result),
      observers: [ReplacementObserver.Instance],
    );
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget _getWidget(AppPath path)
  {
    final uri = Uri.parse(path.innerPath);

    if(uri.pathSegments.isEmpty || uri.pathSegments.first == 'home')
    {
      path.innerPath = Uri.parse(MainProgRouter.defaultRoute).pathSegments.last;
      return _getWidget(path);
    }

    switch(uri.pathSegments.first){
      case 'forums':
        return MainProgRouter._forums;
      case 'exams':
        return MainProgRouter._examDisplay;
      case 'subjects':
        return MainProgRouter._subjectInfoDisplayer;
      case 'semesters':
        return MainProgRouter._semesterInfoDisplayer;
      case 'student_book':
        return MainProgRouter._studentBookDisplayer;
      case 'calendar':
        return MainProgRouter._lessonDisplayer;
      case 'message':
      default:
        return MainProgRouter._messageListDisplay;
    }


  }

  @override
  Future<void> setNewRoutePath(AppPath configuration) async
  {
    final path = stateGetterFn();

    path.innerPath = configuration.innerPath;
    path.settings = configuration.settings;
    
  }

  void SetPath(String path){
    stateGetterFn().innerPath = path;
  }

}

class AppRouterOnformatioParser extends RouteInformationParser<AppPath>{
  @override
  Future<AppPath> parseRouteInformation(RouteInformation routeInformation) async {
    var appPath = AppPath((routeInformation.location != null && routeInformation.location!.length > 1) ? routeInformation.location!.substring(1) : '');
    return appPath;
  }
  
}