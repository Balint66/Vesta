import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/web/fetchManager.dart';

class AdvancedSettings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => AdvancedSettingsState();

}

class AdvancedSettingsState extends State<AdvancedSettings>
{

  var rnd = Random();

  @override
  Widget build(BuildContext context)
  {

    var data = Vesta.of(context).settings;
    var translator = AppTranslations.of(context);
    List cuteMessages = translator.translateRaw('cute_messages');

    var options = <Widget>[
      ListTile(
            title: Text(translator.translate('settings_cuteness')),
            onTap:()=> MessageManager.showNotification(cuteMessages[rnd.nextInt(cuteMessages.length)], type: NotificationType.BIGTEXT)
          ),
      CheckboxListTile(value: data.devMode,
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

    if(data.devMode) {
          options.addAll(<Widget>[
          ListTile(title: Text(translator.translate('settings_clear_cache')),
            onTap: ()
            {
              Vesta.of(context).manuallySetPageChange();
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

    return Scaffold(appBar: AppBar(title: Text(translator.translate('settings_advanced'))),
      body: ListView(children: options)
    );
  }

}