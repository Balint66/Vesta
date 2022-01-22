import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/settings/filcTile.dart';
import 'package:vesta/web/webServices.dart';

class AboutPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {

    final translator = AppTranslations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(translator.translate('settings_about'))),
      body: ListView(
        children: [
          ListTile(leading: Icon(Icons.info_outline), title: Text(translator.translate('settings_privacy')), onTap: ()
          {
            showDialog(context: context, builder:(ctx)=> Dialog(child: FutureBuilder(future: WebServices.getAppPrivacyPolicy(), builder: (context, snapshot)
            {
              if(snapshot.hasError)
              {
                return Center(child:Text(snapshot.error.toString()));
              }
              if(snapshot.hasData)
              {
                return Center(child: SingleChildScrollView(child:Container( padding: EdgeInsets.all(25),child: Text(snapshot.data!.toString()),)));
              }
              return Center(child: CircularProgressIndicator());
            }),));
          }),
          ListTile(leading: Icon(FeatherIcons.coffee), title: Text(translator.translate('settings_kofi')),
          onTap: ()=> launch('https://ko-fi.com/projecttorok'),),
          FilcTile()
        ],
      )
    ); 
  }

}