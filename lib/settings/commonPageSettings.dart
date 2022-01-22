import 'package:flutter/material.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'package:vesta/routing/router.dart';
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
    var translator = AppTranslations.of(context);
    var options = <Widget>[
      ListTile(title:Text('Message settings'), onTap: ()=> (Router.of(context).routerDelegate as MainDelegate).SetPath('/settings/pages/messages')),
      MenuSelector(SettingsManager.INSTANCE.settings.appHomePage),
    ];

    return Scaffold(appBar: AppBar(title: Text(translator.translate('settings_common_page'))), 
      body: ListView(children: options),
    );

  }
  
}