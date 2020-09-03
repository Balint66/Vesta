import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/applicationpage/messages/messageListDisplay.dart';
import 'package:vesta/applicationpage/semesters/semesterDisplayer.dart';
import 'package:vesta/applicationpage/studentBook/studentBookDisplay.dart';
import 'package:vesta/applicationpage/subjects/subjectsDisplayer.dart';
import 'package:vesta/routing/router.dart';

class MainProgRouter
{

  static final fluro.Router _mainProgRouter = fluro.Router();

  static final List<UniqueKey> keys = List.of([UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey(), UniqueKey()],growable: false);

  static void registerRoutes()
  {

    VestaRouter.router.define('/app/:inner', handler: _appNestedHandler, transitionType: fluro.TransitionType.cupertino );

    define('/messages', handler: _messageHandler, transitionType: fluro.TransitionType.cupertinoFullScreenDialog);
    define('/calendar', handler: _calendarHandler, transitionType: fluro.TransitionType.cupertinoFullScreenDialog);
    define('/student_book', handler: _studentBookHandler, transitionType: fluro.TransitionType.cupertinoFullScreenDialog);
    define('/semesters', handler: _semesterInfoHandler, transitionType: fluro.TransitionType.cupertinoFullScreenDialog);
    define('/subjects', handler: _subjectHandler, transitionType: fluro.TransitionType.cupertinoFullScreenDialog);

  }

  static void define(String innerPath, {fluro.Handler handler, fluro.TransitionType transitionType})
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

  static final fluro.Handler _messageHandler = fluro.Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {
    return _messageListDisplay;
  });

  static final fluro.Handler _calendarHandler = fluro.Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> querry)
  {
    return _lessonDisplayer;
  });

  static final fluro.Handler _studentBookHandler = fluro.Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _studentBookDisplayer;
  });

  static final fluro.Handler _semesterInfoHandler = fluro.Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {
    return _semesterInfoDisplayer;
  });

  static final fluro.Handler _subjectHandler = fluro.Handler(handlerFunc: (BuildContext ctx, Map<String,dynamic> querry)
  {  
    return _subjectInfoDisplayer;
  });

  static final fluro.Handler _appNestedHandler = fluro.Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> query)
  {

    String path = query['inner'][0];

    if(path == 'home' || path == null || path.isEmpty) {
      path = defaultRoute;
    }

    return MainProgram(key:VestaRouter.mainKey, route: path,);
  });

  static Widget _wrapinFutureBuilder(BuildContext ctx ,Widget child, PopupMenuItemBuilder<int> builder, PopupMenuItemSelected<int> selector)
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
  }
}