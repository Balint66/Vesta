import 'package:flutter/cupertino.dart';
import 'package:vesta/settings/aboutpage.dart';
import 'package:vesta/settings/accountSettings.dart';
import 'package:vesta/settings/advancedSettings.dart';
import 'package:vesta/settings/commonPageSettings.dart';
import 'package:vesta/settings/uiSettings.dart';

import 'MainSettingsPage.dart';

typedef _getSettingsPath = SettingsPath Function();
typedef _setSettingsPath = void Function(SettingsPath path);

class SettingsRouter
{

  static final _mainSettingsPage = MainSettingsPage();
  static final _uiSettingsPage = UISettings();
  static final _advancedSettingsPage = AdvancedSettings();
  static final _schoolSettingsPage = AccountSettings();
  static final _aboutSettingsPage = AboutPage();

  final _getSettingsPath _pathProvider;
  final _setSettingsPath _pathSetter;
  final PageRouter _pageRouter;
  
  SettingsRouter(pathProvider, this._pathSetter) : _pathProvider = pathProvider, _pageRouter = PageRouter(pathProvider);

  static SettingsPath resolve(String path){
    final uri = Uri.parse(path);

    if(uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'pages'){
      return PageSettings('/' + ( uri.pathSegments.length > 1 ? uri.pathSegments.sublist(1).join('/') : ''));
    }

    return BaseSettings(path);

  }

  List<Page> getPages(SettingsPath path)
  {
    var ls = <Widget>[_mainSettingsPage];

    final uri = Uri.parse(path.path);

    if(uri.pathSegments.isNotEmpty)
    {
      switch(uri.pathSegments.first){
        case 'about':
          ls.add(_aboutSettingsPage);
          break;
        case 'account':
          ls.add(_schoolSettingsPage);
          break;
        case 'advanced':
          ls.add(_advancedSettingsPage);
          break;
        case 'ui':
          ls.add(_uiSettingsPage);
          break;
      }
    }

    if(path is PageSettings)
    {
      ls.addAll(_pageRouter.resolve(path));
    }

    return ls.map((i)=>CupertinoPage(child: i)).toList();
  }

  void SetPath(String path)
  {
    _pathSetter(resolve(path));
  }

  Future<void> setNewRoutePath(SettingsPath configuration) async {
    _pathSetter(configuration);
  }

}

abstract class SettingsPath{
  String path;
  bool fastReturn = false;

  SettingsPath(this.path);

}

class BaseSettings extends SettingsPath
{
  BaseSettings(String path) : super(path);
}

class PageSettings extends SettingsPath {
  String innerPath;
  PageSettings(this.innerPath) : super('/pages');
}

class PageRouter 
{

  static final _commonPageSettings = CommonPageSettings();

  final _getSettingsPath _pathProvider;

  PageRouter(this._pathProvider);

  List<Widget> resolve(PageSettings settings)
  {
    return [_commonPageSettings];
  }
  
}