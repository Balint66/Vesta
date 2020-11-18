import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vesta/settings/pageSettings/data/messagePageData.dart';
import 'package:vesta/settings/pageSettingsData.dart';

class SettingsData
{

  Color mainColor = Colors.red;
  bool isDarkTheme = SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
  bool stayLogged = true;
  String appHomePage = '/messages';
  bool eulaAccepted = false;
  String language = 'en';
  bool devMode = false;
  bool syncLangWithNeptun = true;
  Map<String, PageSettingsData?> pageSettings = <String, PageSettingsData>{
    'messages': MessagePageData()
  };

  String toJsonString()
  {
    return json.encode(<String,dynamic>
    {
      'isDarkTheme':isDarkTheme,
      'stayLogged': stayLogged,
      'appHomePage':appHomePage,
      'eulaAccepted': eulaAccepted,
      'language':language,
      'devMode': devMode,
      'syncLang': syncLangWithNeptun,
      'mainColor':<String,dynamic>
      {
        'r':mainColor.red,
        'g':mainColor.green,
        'b':mainColor.blue,
        'a':mainColor.alpha
      },
      'pageSettings': pageSettings.map((key, value) => MapEntry(key, value?.toJson()))
    });
  }

  static SettingsData fromJsonString(String str)
  {
    var map = json.decode(str);
    var colormap = map['mainColor'] as Map<String,dynamic>?;

    var data = SettingsData();

    data.isDarkTheme = map['isDarkTheme'] ?? false;
    data.stayLogged = map['stayLogged'] ?? data.stayLogged;
    data.appHomePage = map['appHomePage'] ?? '/messages';
    data.eulaAccepted = map['eulaAccepted'] ?? false;
    data.language = map['language'] ?? 'en';
    data.devMode = map['devMode'] ?? false;
    data.syncLangWithNeptun = map['syncLang'] ?? data.syncLangWithNeptun;
    if(colormap != null)
    {
    data.mainColor = Color.fromARGB(colormap['a'] ?? 255,
      colormap['r'] ?? 255,
      colormap['g'] ?? 0,
      colormap['b'] ?? 0);
    }
    else
    {
      data.mainColor = Colors.red;
    }


    data.pageSettings = data.pageSettings
    .map((key, value) => MapEntry(key, PageSettingsData.fromJson((map['pageSettings'] as Map<String, dynamic>)[key])));

    return data;

  }

  static SettingsData copyOf(SettingsData other)
  {
    
    var data = SettingsData();

    data.eulaAccepted = other.eulaAccepted;
    data.isDarkTheme = other.isDarkTheme;
    data.appHomePage = other.appHomePage;
    data.mainColor = other.mainColor;
    data.stayLogged = other.stayLogged;
    data.language = other.language;
    data.devMode = other.devMode;
    data.syncLangWithNeptun = other.syncLangWithNeptun;
    data.pageSettings = other.pageSettings;

    return data;

  }

}