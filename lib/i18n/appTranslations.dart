import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic>? _localisedValues;

  AppTranslations(this.locale);

  static AppTranslations of(BuildContext context) => Localizations.of<AppTranslations>(context, AppTranslations)!;

  static Future<AppTranslations> load(Locale locale) async 
  {

    var appTranslations = AppTranslations(locale);
    var jsonContent = await rootBundle.loadString('assets/i18n/localization_${locale.languageCode}.json');
    _localisedValues = json.decode(jsonContent);
    return appTranslations;

  }

  String get currentLanguage => locale.languageCode;

  String translate(String key) => translateRaw(key).toString();
  dynamic translateRaw(String key) => _localisedValues![key] ?? '$key not found';
  
}