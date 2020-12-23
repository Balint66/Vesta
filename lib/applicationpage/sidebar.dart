import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/routing/replacementObserver.dart';

class Sidebar extends StatefulWidget
{

  Sidebar({Key? key}) : super(key:key);

  final List<UniqueKey> keys = List.generate(7, (index) => UniqueKey());

  @override
  State<StatefulWidget> createState()
  {
    return SideBarState();
  }

}

class SideBarState extends State<Sidebar>
{

  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);

    return Drawer(
        child: Scaffold(
            appBar: AppBar(
              title: Text(StudentData.Instance!.username!),
              primary: false,
              automaticallyImplyLeading: false,
            ),
            bottomNavigationBar: FlatButton.icon(
                onPressed: ()
                {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings/main');
                },
                icon:Icon(Icons.settings),
                label: Text(
                    translator.translate('sidebar_settings'),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
            //TODO: implement missing buttons
            body: ListView(
              children: <Widget>[
                MenuButtons(translator.translate('sidebar_messages'),Icons.message,'/app/messages', key: widget.keys[0],),
                MenuButtons(translator.translate('sidebar_forum'),Icons.wrap_text,'',key: widget.keys[1],),
                MenuButtons(translator.translate('sidebar_calendar'),Icons.calendar_today,'/app/calendar',key: widget.keys[2],),
                MenuButtons(translator.translate('sidebar_subjects'),Icons.book,'/app/subjects',key: widget.keys[3],),
                MenuButtons(translator.translate('sidebar_exams'),Icons.school,'',key: widget.keys[4],),
                MenuButtons(translator.translate('sidebar_student_book'),Icons.local_library,'/app/student_book',key: widget.keys[5],),
                MenuButtons(translator.translate('sidebar_semesters'),Icons.hourglass_empty,'/app/semesters',key: widget.keys[6],),
              ],
            )
        )
    );
  }

}

typedef ReplaceFn = void Function({Route? route});

class _ReplaceDetector with ReplacementAware
{

  ReplaceFn replace = ({Route? route}){};
  ReplaceFn replaced = ({Route? route}){};

  @override
  void didReplaceOther({Route? oldRoute})
  {
    replace.call(route: oldRoute);
  }

  @override
  void wasReplacedBy({Route? otherRoute})
  {
    replaced.call(route: otherRoute);
  }
  
}

class MenuButtons extends StatefulWidget
{

  final String text;
  final IconData icon;
  final _ReplaceDetector observer;
  final String path;


  MenuButtons(this.text,this.icon, String path, {Key? key}) : observer = _ReplaceDetector(), path = path, super(key: key)
  {

    if(path.isNotEmpty) {
      ReplacementObserver.Instance.subscribe(observer, path);
    }
  }

  @override
  State<StatefulWidget> createState()
  {
    return MenuButtonState();
  }

}

class MenuButtonState extends State<MenuButtons>
{

  bool enabled = true;

  void setStatusEnabled(bool enabled)
  {
    if(mounted) {
      setState(() {
      this.enabled = enabled;
    });
    }
  }

  @override
  void initState() {
    super.initState();

    if(widget.path.isEmpty || widget.path == ReplacementObserver.Instance.currentPath) {
      enabled = false;
    }

    widget.observer.replace =  ({Route? route}) => didReplaceOther(oldRoute: route);

    widget.observer.replaced = ({Route? route}) => wasReplacedBy(otherRoute: route);

  }

  @override
  Widget build(BuildContext context)
  {

    return Align( alignment: Alignment.centerLeft,
        child: FlatButton.icon(onPressed:
            () 
            {
              if(enabled)
              {
                MainProgram.navKey.currentState!.pushNamedAndRemoveUntil(widget.path, (_) => true);
                Navigator.of(context).pop();
              }
            },
          icon: Padding(padding: EdgeInsets.symmetric(horizontal: 1.0),
              child: Icon(widget.icon)),
          label: Expanded(child: Text(widget.text)),
      )
    );
  }

  void didReplaceOther({Route? oldRoute})
  {
    setStatusEnabled(true);
  }

  void wasReplacedBy({Route? otherRoute})
  {
    setStatusEnabled(false);
  }

}