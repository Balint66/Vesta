import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/i18n/localizedApp.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale? newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) => application.supportedLanguagesCodes.contains(locale.languageCode);
  

  @override
  Future<AppTranslations> load(Locale locale) => AppTranslations.load(newLocale ?? locale);
  

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) => true;
  
}