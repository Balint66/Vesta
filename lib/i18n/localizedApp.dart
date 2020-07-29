import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:vesta/i18n/appTranslationsDelegate.dart';
class LocalizedApplication extends ChangeNotifier
 {

    static final LocalizedApplication _application = LocalizedApplication._internal();
    AppTranslationsDelegate _delegate = AppTranslationsDelegate(newLocale: null);
    AppTranslationsDelegate get appDelegate => _delegate;

    factory LocalizedApplication() =>_application;

    LocalizedApplication._internal();

    final List<String> supportedLanguages = [
      'English',
      'Magyar',
    ];

    final List<String> supportedLanguagesCodes = [
      'en',
      'hu',
    ];

    //returns the list of supported Locales
    Iterable<Locale> supportedLocales() => supportedLanguagesCodes.map<Locale>((language) => Locale(language, ''));

    void changeLocal(Locale type)
    {

      _delegate = AppTranslationsDelegate(newLocale: type);
      notifyListeners();

    }

}
LocalizedApplication application = LocalizedApplication();