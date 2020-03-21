import 'package:flutter/material.dart';

class ColoredThemeData
{

  factory ColoredThemeData() => null ;

  ColoredThemeData._(); // ignore: unused_element

  static ThemeData create({MaterialColor primarySwatch, Brightness brightness})
  {
    return ThemeData(primarySwatch: primarySwatch,
        primaryColor: primarySwatch, accentColor: primarySwatch[500],
        toggleableActiveColor: brightness == Brightness.dark ? primarySwatch[600] : null,
        brightness: brightness);
  }

}