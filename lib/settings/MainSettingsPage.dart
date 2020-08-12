import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/i18n/localizedApp.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/settings/colorSelector.dart';
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

  Random rnd = Random();

  @override
  Widget build(BuildContext context)
  {

    var data = Vesta.of(context).settings;
    var translator = AppTranslations.of(context);
    List cuteMessages = translator.translateRaw('cute_messages');

    var options = <Widget>[
          ListTile(title: Text(translator.translate('settings_logout')),
          onTap: ()
          {
            FileManager.clearFileData();
            FetchManager.clearRegistered();
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          },),
          ListTile(
            title: Text(translator.translate('settings_color')),
            onTap: ()=>showDialog(context: context, builder: (BuildContext ctx) => ColorSelector()),
            trailing: Container(
              width: 35.5,
              height: 32.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data.mainColor
              ),
            ),
          ),
           CheckboxListTile(
               value: data.isDarkTheme,
               onChanged:  (bool value){Vesta.of(context).updateSettings(isDarkTheme: value);},
                title: Text(translator.translate('settings_dark_theme')),
           ),
           PopupMenuButton(itemBuilder: (context) 
           {
              return application.supportedLanguages.map((e) => PopupMenuItem<int>(child: Text(e), value: application.supportedLanguages.indexOf(e),)).toList();
           },
           padding: const EdgeInsets.all(0),
           onSelected: (value)
           {
             application.changeLocal(Locale(application.supportedLanguagesCodes[value]));
             Vesta.of(context).updateSettings(language: application.supportedLanguagesCodes[value]);
           },
           child: ListTile(title: Text("${translator.translate("settings_lang")} ${application.supportedLanguages[application.supportedLanguagesCodes.indexOf(
             application.appDelegate.newLocale == null ? Localizations.localeOf(context).languageCode : application.appDelegate.newLocale.languageCode
             )]}"),
           ),
           tooltip: translator.translate('settings_lang_tooltip'),
           ),
           ListTile(
             title: Text(translator.translate('settings_cuteness')),
             onTap:()=> MessageManager.showNotification(cuteMessages[rnd.nextInt(cuteMessages.length)], type: NotificationType.BIGTEXT) //Vesta.showSnackbar(Text(cuteMessages[rnd.nextInt(cuteMessages.length)]))
           ),
           ListTile(
             title: Text(translator.translate('settings_schools_privacy')),
             onTap: ()=>showDialog(context: context, builder:(ctx)=>Dialog(child: FutureBuilder(
               future: WebServices.getSchoolsPrivacyPolicy(Data.school),
               builder: (context, snapshot) 
               {
                  if(snapshot.hasError) {
                    return SingleChildScrollView(child: Center(child: Text(snapshot.error)));
                  }

                  if(!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Text('${snapshot.data}');

               },
             ))),
           ),
          CheckboxListTile(value: Vesta.of(context).settings.devMode,
            onChanged: (value) async 
            {
              if(value)
              {
                var val = false;
                await showDialog<bool>(builder: (BuildContext context)
                {
                  return AlertDialog(
                    content: Text(translator.translate('settings_dev_notice')),
                    actions: [
                      MaterialButton(onPressed: ()
                      {
                        val = false;
                        Navigator.pop(context);
                      },
                      child: Text(translator.translate('cancel')),
                      ),
                      MaterialButton(onPressed: ()
                      {
                        val = true;
                        Navigator.pop(context);
                      },
                      child: Text(translator.translate('settings_dev_notice_ok')),
                      )
                    ],
                    );
                }, context: context);

                if(val) {
                  Vesta.of(context).updateSettings(devMode: val);
                }
              }
              else {
                Vesta.of(context).updateSettings(devMode: value);
              }
            },
            title: Text(translator.translate('settings_dev')),)
        ];

        if(Vesta.of(context).settings.devMode) {
          options.addAll(<Widget>[
          ListTile(title: Text(translator.translate('settings_clear_cache')),
            onTap: ()
            {
              //MainProgramState.of(context).refreshListHolders();
            },),
          ListTile(title: Text(translator.translate('settings_hard_reset')),
          onTap: ()
          {
            Vesta.of(context).resetSettings();
            FileManager.clearAllFileData();
            FetchManager.clearRegistered();
            Navigator.of(context).pushNamedAndRemoveUntil('/eula', (route) => false);
          }),
        ]);
        }

    return Scaffold(
        appBar: AppBar(title: Text(translator.translate('settings')),),
        body: ListView(children: options)
    );
  }

}