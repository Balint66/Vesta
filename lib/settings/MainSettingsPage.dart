import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/settings/colorSelector.dart';
import 'package:vesta/settings/settingsData.dart';
import 'package:vesta/web/fetchManager.dart';

class MainSettingsPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return new _MainSettingsPageState();
  }

}

class _MainSettingsPageState extends State<MainSettingsPage>
{
  @override
  Widget build(BuildContext context)
  {

    SettingsData data = Vesta.of(context).settings;

    return new Scaffold(
        appBar: new AppBar(title: new Text("Settings"),),
        body: new ListView(children: <Widget>[
          new ListTile(title: new Text("Logout"),
          onTap: ()
          {
            FileManager.clearFileData();
            FetchManager.clearRegistered();
            Navigator.pushReplacementNamed(context, "/login");
          },),
          new ListTile(
            title: new Text("Color"),
            onTap: ()=>showDialog(context: context, builder: (BuildContext ctx) => ColorSelector()),
            trailing: new Container(
              width: 35.5,
              height: 32.5,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: data.mainColor
              ),
            ),
          ),
           new CheckboxListTile(
               value: data.isDarkTheme,
               onChanged:  (bool value){Vesta.of(context).updateSettings(isDarkTheme: value);},
                title: new Text("Dark theme"),
           )
        ],)
    );
  }

}