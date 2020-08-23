import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/i18n/localizedApp.dart';
import 'package:vesta/settings/colorSelector.dart';
import 'package:vesta/settings/settingsData.dart';

class UISettings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => UISettingsState();
}

class UISettingsState extends State<UISettings>
{
  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);
    var data = Vesta.of(context).settings;

    var options = <Widget>[
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
    ];

    return Scaffold(
      appBar: AppBar(title: Text('UI Settings')),
      body: ListView(children: options,),
    );  
  }
  
}