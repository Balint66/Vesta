import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SettingsData
{

  Color mainColor = Colors.red;
  bool isDarkTheme = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  bool stayLogged = false;
  String appHomePage = '/messages';
  bool eulaAccepted = false;
  String language = 'en';
  bool devMode = false;

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
      'mainColor':<String,dynamic>
      {
        'r':mainColor.red,
        'g':mainColor.green,
        'b':mainColor.blue,
        'a':mainColor.alpha
      }
    });
  }

  static SettingsData fromJsonString(String str)
  {
    var map = json.decode(str);
    var colormap = map['mainColor'] as Map<String,dynamic>;

    var data = SettingsData();

    data.isDarkTheme = map['isDarkTheme'] ?? false;
    data.stayLogged = map['stayLogged'] ?? false;
    data.appHomePage = map['appHomePage'] ?? '/messages';
    data.eulaAccepted = map['eulaAccepted'] ?? false;
    data.language = map['language'] ?? 'en';
    data.devMode = map['devMode'] ?? false;
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

    return data;

  }

}