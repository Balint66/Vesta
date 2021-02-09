import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/datastorage/local/persistentDataManager.dart';
import 'package:vesta/settings/pageSettingsData.dart';
import 'package:vesta/settings/settingsData.dart';

class SettingsManager
{
  var _settings = SettingsData();
  SettingsData get settings => SettingsData.copyOf(_settings);

  void resetSettings() =>
      _settings = SettingsData();
  
  void updateSettings({Color? mainColor, bool? isDarkTheme, bool? keepMeLogged,
    String? route, bool? eulaWasAccepted, String? language, bool? devMode, bool? syncLang})
  {

    if(mainColor == null && isDarkTheme == null && keepMeLogged == null
        && route == null && eulaWasAccepted == null && language == null && devMode == null && syncLang == null) {
      return;
    }
      if(mainColor != null) {
        _settings.mainColor = mainColor;
      }
      if(isDarkTheme != null) {
        _settings.isDarkTheme = isDarkTheme;
      }
      if(keepMeLogged != null) {
        _settings.stayLogged = keepMeLogged;
      }
      if(eulaWasAccepted != null) {
        _settings.eulaAccepted = eulaWasAccepted;
      }
      if(route!= null)
      {
        _settings.appHomePage = '/' + route.split('/')[2];
        MainProgRouter.defaultRoute = route;
      }
      if(language != null){
        _settings.language = language;
      }
      if(devMode != null){
        _settings.devMode = devMode;
      }
      if(syncLang != null)
      {
        _settings.syncLangWithNeptun = syncLang;
      }
      FileManager.saveSettings(_settings);
  }

  void loadSettings() async
  {
    var newSettings = await FileManager.loadSettings();
      if(newSettings != null) {
        _settings = newSettings;
      }
  }

  void updatePageSettings(String page, PageSettingsData data)
  {
    _settings.pageSettings[page] = data;
    FileManager.saveSettings(_settings);
  }

}