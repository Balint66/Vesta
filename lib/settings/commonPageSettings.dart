import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/settings/menuSelector.dart';

class CommonPageSettings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => CommonPageSettingsState();

}

class CommonPageSettingsState extends State<CommonPageSettings>
{
  @override
  Widget build(BuildContext context) 
  {
    var options = <Widget>[
      ListTile(title:Text('Message settings'), onTap: ()=> Navigator.of(context).pushNamed('/pageSettings/messages')),
      MenuSelector(Vesta.of(context).settings.appHomePage),
    ];

    return Scaffold(appBar: AppBar(title: Text('Page Settings')), 
      body: ListView(children: options),
    );

  }
  
}