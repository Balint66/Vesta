import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SettingsData
{

  Color mainColor = Colors.red;
  bool isDarkTheme = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  bool stayLogged = false;
  String appHomePage = "/messages";
  bool eulaAccepted = false;
  String language = "en";
  bool devMode = false;

  String toJsonString()
  {
    return json.encode(<String,dynamic>
    {
      "isDarkTheme":isDarkTheme,
      "stayLogged": stayLogged,
      "appHomePage":appHomePage,
      "eulaAccepted": eulaAccepted,
      "language":language,
      "devMode": devMode,
      "mainColor":<String,dynamic>
      {
        "r":mainColor.red,
        "g":mainColor.green,
        "b":mainColor.blue,
        "a":mainColor.alpha
      }
    });
  }

  static SettingsData fromJsonString(String str)
  {
    Map<String, dynamic> map = json.decode(str);
    Map<String, dynamic> colormap = map["mainColor"] as Map<String,dynamic>;

    SettingsData data = new SettingsData();

    data.isDarkTheme = map["isDarkTheme"] == null ? false : map["isDarkTheme"];
    data.stayLogged = map["stayLogged"] == null ? false : map["stayLogged"];
    data.appHomePage = map["appHomePage"] == null ? "/messages" : map["appHomePage"];
    data.eulaAccepted = map["eulaAccepted"] == null ? false : map["eulaAccepted"];
    data.language = map["language"] == null ? "en" : map["language"];
    data.devMode = map["devMode"] == null ? false : map["devMode"];
    if(colormap != null)
    {
    data.mainColor = Color.fromARGB(colormap["a"] == null ? 255 : colormap["a"],
      colormap["r"] == null ? 255 : colormap["r"],
      colormap["g"] == null ? 0 : colormap["g"],
      colormap["b"] == null ? 0 : colormap["b"]);
    }
    else
    {
      data.mainColor = Colors.red;
    }

    return data;

  }

  static SettingsData copyOf(SettingsData other)
  {
    SettingsData data = new SettingsData();

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