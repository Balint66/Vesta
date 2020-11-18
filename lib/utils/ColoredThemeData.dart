import 'package:flutter/material.dart';

abstract class ColoredThemeData
{

  ColoredThemeData._(); // ignore: unused_element

  static ThemeData create(MaterialColor primarySwatch, Brightness brightness)
  {
    return ThemeData(primarySwatch: primarySwatch,
        primaryColor: primarySwatch, accentColor: primarySwatch[500],
        backgroundColor: brightness == Brightness.dark ? Colors.grey[800] : null,
        toggleableActiveColor: brightness == Brightness.dark ? primarySwatch[600] : null,
        brightness: brightness);
  }

}