import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/routing/router.dart';

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

    final translator = AppTranslations.of(context);

    var options = <Widget>[
          ListTile(leading: Icon(Icons.palette), title: Text(translator.translate('settings_ui')),
            onTap: ()=>(Router.of(context).routerDelegate as MainDelegate).SetPath('/settings/ui')),
          ListTile(leading: Icon(Icons.pageview_outlined), title: Text(translator.translate('settings_common_page')),
            onTap: ()=> (Router.of(context).routerDelegate as MainDelegate).SetPath('/settings/pages')),
          ListTile(leading: Icon(Icons.school_outlined ), title: Text(translator.translate('settings_account')),
            onTap: ()=> (Router.of(context).routerDelegate as MainDelegate).SetPath('/settings/school')),
          ListTile(leading: Icon(FeatherIcons.code), title: Text(translator.translate('settings_advanced')),
            onTap: ()=> (Router.of(context).routerDelegate as MainDelegate).SetPath('/settings/advanced')),
          ListTile(leading: Icon(Icons.info_outline), title: Text(translator.translate('settings_about')),
            onTap: ()=> (Router.of(context).routerDelegate as MainDelegate).SetPath('/settings/about'))
        ];

    return Scaffold(
        appBar: AppBar(title: Text(translator.translate('settings')),),
        body: ListView(children: options)
    );
  }

}