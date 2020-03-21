import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsData
{

  Color mainColor = Colors.red;
  bool isDarkTheme = false;
  bool stayLogged = false;
  String appHomePage = "/messages";

  String toJsonString()
  {
    return json.encode(<String,dynamic>
    {
      "isDarkTheme":isDarkTheme,
      "stayLogged": stayLogged,
      "appHomePage":appHomePage,
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

    data.isDarkTheme = map["isDarkTheme"];
    data.stayLogged = map["stayLogged"];
    data.appHomePage = map["appHomePage"];
    data.mainColor = Color.fromARGB(colormap["a"], colormap["r"], colormap["g"], colormap["b"]);

    return data;

  }

}