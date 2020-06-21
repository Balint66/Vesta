import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/applicationpage/messages/messageListDisplay.dart';
import 'package:vesta/applicationpage/semesters/semesterDisplayer.dart';
import 'package:vesta/applicationpage/studentBook/studentBookDisplay.dart';
import 'package:vesta/applicationpage/subjects/subjectsDisplayer.dart';
import 'package:vesta/routing/router.dart';

class MainProgRouter
{

  static final Router _mainProgRouter = new Router();

  static final List<UniqueKey> keys = List.of([new UniqueKey(), new UniqueKey(), new UniqueKey(), new UniqueKey(), new UniqueKey()],growable: false);

  static void registerRoutes()
  {

    VestaRouter.router.define("/app/:inner", handler: _appNestedHandler);

    define("/messages", handler: _messageHandler);
    define("/calendar", handler: _calendarHandler);
    define("/student_book", handler: _studentBookHandler);
    define("/semester_info", handler: _semesterInfoHandler);
    define("/subjects", handler: _subjectHandler);

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
  static final StudentBookDisplay _studentBookDisplayer = StudentBookDisplay(key: keys[2]);
  static final SemesterDisplayer _semesterInfoDisplayer = SemesterDisplayer(key: keys[3]);
  static final SubjectDisplayer _subjectInfoDisplayer = SubjectDisplayer(key: keys[4]);

  static final Handler _messageHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _messageListDisplay;
  });

  static final Handler _calendarHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> querry)
  {
    return _lessonDisplayer;
  });

  static final Handler _studentBookHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _studentBookDisplayer;
  });

  static final Handler _semesterInfoHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _semesterInfoDisplayer;
  });

  static final Handler _subjectHandler = new Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _subjectInfoDisplayer;
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
    return main;
  });
}