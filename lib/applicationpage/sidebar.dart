
import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/routing/replacementObserver.dart';

class Sidebar extends StatefulWidget
{

  Sidebar({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState()
  {
    return SideBarState();
  }

}

class SideBarState extends State<Sidebar>
{

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
            appBar: AppBar(
              title: Text("User"),
            ),
            bottomNavigationBar: BottomAppBar(
              child: MaterialButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.settings, size: 20),
                      Text(
                        "Settings",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )),
              shape: CircularNotchedRectangle(),
            ),
            //TODO: implement routing and button functions
            body: ListView(
              children: <Widget>[
                MenuButtons("Üzenetek",Icons.message,"/app/messages"),
                MenuButtons("Fórum",Icons.wrap_text,""),
                MenuButtons("Naptár",Icons.calendar_today,""),
                MenuButtons("Tárgyak",Icons.book,""),
                MenuButtons("Vizsgák",Icons.school,""),
                MenuButtons("Lecke Könyv",Icons.local_library,""),
                MenuButtons("Időszakok",Icons.hourglass_empty,""),
              ],
            )
        )
    );
  }

}

class MenuButtons extends StatefulWidget
{

  final String text;
  final IconData icon;
  final String path;

  MenuButtons(this.text,this.icon, String path, {Key key}) :this.path = path, super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return new MenuButtonState();
  }
}

class MenuButtonState extends State<MenuButtons> with ReplacementAware
{

  bool enabled = true;

  void setStatusEnabled(bool enabled)
  {
    setState(() {
      this.enabled = enabled;
    });
  }

  @override
  void initState() {
    super.initState();

    if(widget.path.isEmpty||widget.path == MainProgram.defaultRoute)
      setState(() {
        this.enabled = false;
      });

  }

  @override
  Widget build(BuildContext context)
  {

    if(widget.path.isNotEmpty)
      observer.subscribe(this, widget.path);

    return new Align( alignment: Alignment.centerLeft,
        child: new FlatButton.icon(onPressed: enabled ?
            () => MainProgram.navKey.currentState.pushNamed(widget.path) :
            null,
          icon: new  Padding(padding: EdgeInsets.symmetric(horizontal: 1.0),
              child: new Icon(widget.icon)),
          label: new Text(widget.text),
      )
    );
  }

  @override
  didReplaceOther({Route oldRoute})
  {
    setStatusEnabled(false);
  }

  @override
  wasReplacedBy({Route otherRoute})
  {
    setStatusEnabled(true);
  }

}