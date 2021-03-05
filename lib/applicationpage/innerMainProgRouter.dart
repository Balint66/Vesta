import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/exams/examListDisplay.dart';
import 'package:vesta/applicationpage/forums/forums.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/applicationpage/messages/messageListDisplay.dart';
import 'package:vesta/applicationpage/semesters/semesterDisplayer.dart';
import 'package:vesta/applicationpage/studentBook/studentBookDisplay.dart';
import 'package:vesta/applicationpage/subjects/subjectsDisplayer.dart';
import 'package:vesta/routing/router.dart';

class MainProgRouter
{

  static final _mainProgRouter = FluroRouter();

  static final List<UniqueKey> keys = List.of([UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey()],growable: false);

  static void registerRoutes()
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

  static String defaultRoute = '/app/messages';
  static final MessageListDisplay _messageListDisplay = MessageListDisplay(key: keys[0],);
  static final LessonDisplayer _lessonDisplayer = LessonDisplayer(key: keys[1]);
  static final StudentBookDisplay _studentBookDisplayer = StudentBookDisplay(key: keys[2]);
  static final SemesterDisplayer _semesterInfoDisplayer = SemesterDisplayer(key: keys[3]);
  static final SubjectDisplayer _subjectInfoDisplayer = SubjectDisplayer(key: keys[4]);
  static final ExamListDisplay _examDisplay = ExamListDisplay(key: keys[5]);
  static final Forums _forums = Forums(key: keys[6]);

  static final Handler _messageHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, List<String>>? query)
  {
    return _messageListDisplay;
  }as HandlerFunc);

  static final Handler _calendarHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _lessonDisplayer;
  }as HandlerFunc);

  static final Handler _studentBookHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> query)
  {
    return _studentBookDisplayer;
  }as HandlerFunc);

  static final Handler _semesterInfoHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> query)
  {
    return _semesterInfoDisplayer;
  }as HandlerFunc);

  static final Handler _subjectHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> query)
  {  
    return _subjectInfoDisplayer;
  }as HandlerFunc);

  static final Handler _examsHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> query){
    return _examDisplay;
  }as HandlerFunc);

  static final Handler _forumHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _forums;
  }as HandlerFunc);

  static final Handler _appNestedHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    String? path = query['inner'][0];

    if(path == 'home' || path == null || path.isEmpty) {
      path = defaultRoute;
    }

    return MainProgram(key:VestaRouter.mainKey, route: path,);
  }as HandlerFunc);

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