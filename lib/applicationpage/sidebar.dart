
import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/routing/replacementObserver.dart';

class Sidebar extends StatefulWidget
{

  Sidebar({Key key}) : super(key:key);

  final List<UniqueKey> keys = List.generate(7, (index) => new UniqueKey());

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
                  onPressed: ()
                  {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/settings");
                  },
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
            //TODO: implement missing buttons
            body: ListView(
              children: <Widget>[
                MenuButtons("Üzenetek",Icons.message,"/app/messages", key: widget.keys[0],),
                MenuButtons("Fórum",Icons.wrap_text,"",key: widget.keys[1],),
                MenuButtons("Naptár",Icons.calendar_today,"/app/calendar",key: widget.keys[2],),
                MenuButtons("Tárgyak",Icons.book,"",key: widget.keys[3],),
                MenuButtons("Vizsgák",Icons.school,"",key: widget.keys[4],),
                MenuButtons("Lecke Könyv",Icons.local_library,"",key: widget.keys[5],),
                MenuButtons("Időszakok",Icons.hourglass_empty,"",key: widget.keys[6],),
              ],
            )
        )
    );
  }

}

class MenuButtons extends StatefulWidget with ReplacementAware
{

  final String text;
  final IconData icon;
  final String path;

  MenuButtonState state;


  MenuButtons(this.text,this.icon, String path, {Key key}) :this.path = path, super(key: key)
  {
    if(path.isNotEmpty)
      ReplacementObserver.Instance.subscribe(this, path);
  }

  @override
  State<StatefulWidget> createState()
  {
    state = new MenuButtonState();
    return state;
  }

  @override
  didReplaceOther({Route oldRoute})
  {
    if(state.mounted)
      state.didReplaceOther(oldRoute: oldRoute);
  }

  @override
  wasReplacedBy({Route otherRoute})
  {
    if(state.mounted)
      state.wasReplacedBy(otherRoute: otherRoute);
  }

}

class MenuButtonState extends State<MenuButtons>
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

    if(widget.path.isEmpty || widget.path == ReplacementObserver.Instance.currentPath)
      setState(() {
        this.enabled = false;
      });

  }

  @override
  Widget build(BuildContext context)
  {

    return new Align( alignment: Alignment.centerLeft,
        child: new FlatButton.icon(onPressed: enabled ?
            () => MainProgram.navKey.currentState.pushReplacementNamed(widget.path) :
            null,
          icon: new  Padding(padding: EdgeInsets.symmetric(horizontal: 1.0),
              child: new Icon(widget.icon)),
          label: new Text(widget.text),
      )
    );
  }


  didReplaceOther({Route oldRoute})
  {
    setStatusEnabled(false);
  }

  wasReplacedBy({Route otherRoute})
  {
    setStatusEnabled(true);
  }

}