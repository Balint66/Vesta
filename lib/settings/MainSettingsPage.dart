import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/i18n/localizedApp.dart';
import 'package:vesta/settings/colorSelector.dart';
import 'package:vesta/settings/settingsData.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

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

  Random rnd = new Random();

  @override
  Widget build(BuildContext context)
  {

    SettingsData data = Vesta.of(context).settings;
    var translator = AppTranslations.of(context);
    List cuteMessages = translator.translateRaw("cute_messages");

    List<Widget> options = <Widget>[
          new ListTile(title: new Text(translator.translate("settings_logout")),
          onTap: ()
          {
            FileManager.clearFileData();
            FetchManager.clearRegistered();
            Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
          },),
          new ListTile(
            title: new Text(translator.translate("settings_color")),
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
                title: new Text(translator.translate("settings_dark_theme")),
           ),
           new  PopupMenuButton(itemBuilder: (context) 
           {
              return application.supportedLanguages.map((e) => new PopupMenuItem<int>(child: new Text(e), value: application.supportedLanguages.indexOf(e),)).toList();
           },
           padding: const EdgeInsets.all(0),
           onSelected: (value)
           {
             application.changeLocal(new Locale(application.supportedLanguagesCodes[value]));
             Vesta.of(context).updateSettings(language: application.supportedLanguagesCodes[value]);
           },
           child: ListTile(title: new Text("${translator.translate("settings_lang")} ${application.supportedLanguages[application.supportedLanguagesCodes.indexOf(
             application.appDelegate.newLocale == null ? Localizations.localeOf(context).languageCode : application.appDelegate.newLocale.languageCode
             )]}"),
           ),
           tooltip: translator.translate("settings_lang_tooltip"),
           ),
           new ListTile(
             title: new Text(translator.translate("settings_cuteness")),
             onTap:()=>Vesta.showSnackbar(new Text(cuteMessages[rnd.nextInt(cuteMessages.length)]))
           ),
           new ListTile(
             title: new Text(translator.translate("settings_schools_privacy")),
             onTap: ()=>showDialog(context: context, builder:(ctx)=>new Dialog(child: new FutureBuilder(
               future: WebServices.getSchoolsPrivacyPolicy(Data.school),
               builder: (context, snapshot) 
               {
                  if(snapshot.hasError)
                    return new SingleChildScrollView(child: new Center(child: new Text(snapshot.error)));

                  if(!snapshot.hasData)
                    return new Center(child: new CircularProgressIndicator());

                  return new Text("${snapshot.data}");

               },
             ))),
           ),
          new CheckboxListTile(value: Vesta.of(context).settings.devMode,
            onChanged: (value) async 
            {
              if(value)
              {
                bool val = false;
                await showDialog<bool>(builder: (BuildContext context)
                {
                  return new AlertDialog(
                    content: new Text("Are you sure?\nAfter setting this setting to true\nevery developer action you'll make is inreversable!"),
                    actions: [
                      new MaterialButton(onPressed: ()
                      {
                        val = false;
                        Navigator.pop(context);
                      },
                      child: new Text("Cancel"),
                      ),
                      new MaterialButton(onPressed: ()
                      {
                        val = true;
                        Navigator.pop(context);
                      },
                      child: new Text("Understood Captian!"),
                      )
                    ],
                    );
                }, context: context);

                if(val)
                  Vesta.of(context).updateSettings(devMode: val);
              }
              else
                Vesta.of(context).updateSettings(devMode: value);
            },
            title: new Text("Dev Mode"),)
        ];

        if(Vesta.of(context).settings.devMode)
        options.addAll(<Widget>[
          new ListTile(title: new Text("Clear cache"),
            onTap: ()
            {
              //MainProgramState.of(context).refreshListHolders();
            },),
          new ListTile(title: new Text("Hard reset"),
          onTap: ()
          {
            Vesta.of(context).resetSettings();
            FileManager.clearAllFileData();
            FetchManager.clearRegistered();
            Navigator.of(context).pushNamedAndRemoveUntil("/eula", (route) => false);
          }),
        ]);

    return new Scaffold(
        appBar: new AppBar(title: new Text(translator.translate("settings")),),
        body: new ListView(children: options)
    );
  }

}