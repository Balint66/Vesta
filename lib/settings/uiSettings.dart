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
              onChanged:  (bool? value){Vesta.of(context).updateSettings(isDarkTheme: value);},
                title: Text(translator.translate('settings_dark_theme')),
          ),
          CheckboxListTile(
            value: data.syncLangWithNeptun,
            title: Text('Sync language with Neptun'),
            onChanged: (value)
            {

              if(value == null)
              {
                return;
              }

              setState(()
              {
                if(value)
                {
                  switch(Vesta.of(context).settings.language)
                  {
                    case 'en':
                      Vesta.of(context).updateSettings(neptunLang:en_us_LCID);
                      //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: en_us_LCID);
                      break;
                    case 'hu':
                    default:
                      Vesta.of(context).updateSettings(neptunLang:hun_LCID);
                      //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: hun_LCID);
                      break;
                  }
                }

                Vesta.of(context).updateSettings(syncLang: value);
              });
            }),
          PopupMenuButton(itemBuilder: (context) 
            {
              return application.supportedLanguages.map((e) => PopupMenuItem<int>( value: application.supportedLanguages.indexOf(e),child: Text(e),), ).toList();
            },
            padding: const EdgeInsets.all(0),
            onSelected: (int value)
            {
              application.changeLocal(Locale(application.supportedLanguagesCodes[value]));
              Vesta.of(context).updateSettings(language: application.supportedLanguagesCodes[value]);

              if(data.syncLangWithNeptun)
              {

                setState(() {
                  Vesta.of(context).manuallySetPageChange();

                  switch(value)
                  {
                    case 2:
                      Vesta.of(context).updateSettings(neptunLang:de_LCID);
                      //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: de_LCID);
                      break;
                    case 1:
                      Vesta.of(context).updateSettings(neptunLang:hun_LCID);
                      //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: hun_LCID);
                      break;
                    case 0:
                    default:
                      Vesta.of(context).updateSettings(neptunLang:en_us_LCID);
                      //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: en_us_LCID);
                      break;
                  }
                });

              }

            },
            tooltip: translator.translate('settings_lang_tooltip'),
            child: ListTile(title: Text("${translator.translate("settings_lang")} ${application.supportedLanguages[application.supportedLanguagesCodes.indexOf(
              application.appDelegate.newLocale == null ? Localizations.localeOf(context).languageCode : application.appDelegate.newLocale!.languageCode
              )]}"),
            ),
          ),
          PopupMenuButton(itemBuilder: (context){
            return [PopupMenuItem<int>( value: 0,child: Text('Magyar'), ), PopupMenuItem<int>( value: 1,child: Text('English (US)'), ), PopupMenuItem<int>( value: 2,child: Text('Deutsch'), )];
          },
          enabled: !data.syncLangWithNeptun,
          onSelected: (int value)
          {
            
            setState((){
              Vesta.of(context).manuallySetPageChange();
              switch(value)
              {
                case 2:
                  Vesta.of(context).updateSettings(neptunLang:de_LCID);
                  //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: de_LCID);
                  break;
                case 1:
                  Vesta.of(context).updateSettings(neptunLang:en_us_LCID);
                  //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: en_us_LCID);
                  break;
                case 0:
                default:
                  Vesta.of(context).updateSettings(neptunLang:hun_LCID);
                  //AccountData.setInstance(AccountData.Instance!.username!, AccountData.Instance!.password!, AccountData.Instance!.training, LCID: hun_LCID);
                  break;
              }
            });
          },
          child: ListTile(
            title:Text('Neptun\'s language: ' + (data.neptunLang == hun_LCID ? 'Magyar' : data.neptunLang == de_LCID ? 'Deutsch' : 'English (US)'),
            style: TextStyle(color: data.syncLangWithNeptun ? Theme.of(context).disabledColor : Theme.of(context).textTheme.bodyText1!.color )),
            ),
          )
    ];

    return Scaffold(
      appBar: AppBar(title: Text(translator.translate('settings_ui'))),
      body: ListView(children: options,),
    );  
  }
  
}