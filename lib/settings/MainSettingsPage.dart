import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/settings/menuSelector.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

class MainSettingsPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _MainSettingsPageState();
  }

}

class _MainSettingsPageState extends State<MainSettingsPage>
{

  @override
  Widget build(BuildContext context)
  {

    var data = Vesta.of(context).settings;
    var translator = AppTranslations.of(context);

    var options = <Widget>[
          ListTile(leading: Icon(Icons.palette), title: Text('UI Settings'), onTap: ()=> Navigator.of(context).pushNamed('/settings/ui')),
          ListTile(leading: Icon(Icons.pageview_outlined), title: Text('Page Settings'), onTap: ()=> Navigator.of(context).pushNamed('/settings/page')),
          ListTile(leading: Icon(Icons.school_outlined ), title: Text('School Settings'), onTap: ()=> Navigator.of(context).pushNamed('/settings/school')),
          ListTile(leading: Icon(Icons.developer_mode_outlined), title: Text('Advanced Settings'), onTap: ()=> Navigator.of(context).pushNamed('/settings/advanced')),
        ];

    return Scaffold(
        appBar: AppBar(title: Text(translator.translate('settings')),),
        body: ListView(children: options)
    );
  }

}