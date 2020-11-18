import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
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

  static final _mainProgRouter = FluroRouter();

  static final List<UniqueKey> keys = List.of([UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey()],growable: false);

  static void registerRoutes()
  {

    VestaRouter.router.define('/app/:inner', handler: _appNestedHandler, transitionType: TransitionType.cupertino );

    define('/messages', handler: _messageHandler, transitionType: TransitionType.cupertinoFullScreenDialog);
    define('/calendar', handler: _calendarHandler, transitionType: TransitionType.cupertinoFullScreenDialog);
    define('/student_book', handler: _studentBookHandler, transitionType: TransitionType.cupertinoFullScreenDialog);
    define('/semesters', handler: _semesterInfoHandler, transitionType: TransitionType.cupertinoFullScreenDialog);
    define('/subjects', handler: _subjectHandler, transitionType: TransitionType.cupertinoFullScreenDialog);

  }

  static void define(String innerPath, {Handler? handler, TransitionType? transitionType})
  {
    _mainProgRouter.define('/app$innerPath', handler: handler, transitionType: transitionType);
  }

  static Route route(RouteSettings settings)
  {
    return _mainProgRouter.generator(settings);
  }

  static String defaultRoute = '/app/messages';
  static final MessageListDisplay _messageListDisplay = MessageListDisplay(key: keys[0],);
  static final LessonDisplayer _lessonDisplayer = LessonDisplayer(key: keys[1]);
  static final StudentBookDisplay _studentBookDisplayer = StudentBookDisplay(key: keys[2]);
  static final SemesterDisplayer _semesterInfoDisplayer = SemesterDisplayer(key: keys[3]);
  static final SubjectDisplayer _subjectInfoDisplayer = SubjectDisplayer(key: keys[4]);

  static final Handler _messageHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _messageListDisplay;
  });

  static final Handler _calendarHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> querry)
  {
    return _lessonDisplayer;
  });

  static final Handler _studentBookHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _studentBookDisplayer;
  });

  static final Handler _semesterInfoHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _semesterInfoDisplayer;
  });

  static final Handler _subjectHandler = Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {  
    return _subjectInfoDisplayer;
  });

  static final Handler _appNestedHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    String? path = query['inner'][0];

    if(path == 'home' || path == null || path.isEmpty) {
      path = defaultRoute;
    }

    return MainProgram(key:VestaRouter.mainKey, route: path,);
  });

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