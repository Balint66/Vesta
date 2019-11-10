
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget
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
                  onPressed: null,
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
            body: ListView(
              children: <Widget>[
                MaterialButton(
                  onPressed: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.values[0],
                    children: <Widget>[
                      Icon(Icons.message),
                      Text(" Üzenetek")
                    ],
                  ),
                ),
                MaterialButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      children: <Widget>[
                        Icon(Icons.wrap_text),
                        Text(" Fórum")
                      ],
                    )),
                MaterialButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        Text(" Naptár")
                      ],
                    )),
                MaterialButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      children: <Widget>[
                        Icon(Icons.book),
                        Text(" Tárgyak")
                      ],
                    )),
                MaterialButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      children: <Widget>[
                        Icon(Icons.school),
                        Text(" Vizsgák")
                      ],
                    )),
                MaterialButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      children: <Widget>[
                        Icon(Icons.local_library),
                        Text(" Lecke könyv")
                      ],
                    )),
                MaterialButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      children: <Widget>[
                        Icon(Icons.hourglass_empty),
                        Text(" Időszakok")
                      ],
                    ))
              ],
            )
        )
    );
  }

}