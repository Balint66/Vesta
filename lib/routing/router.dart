import 'package:flutter/cupertino.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/eulapage/Eulapage.dart';
import 'package:vesta/loginpage/Authorization.dart';
import 'package:vesta/settings/router.dart';

//Settings router: router inside a router, no intermediate widget.

abstract class MainPath{
  String get path;
  SettingsPath? settings;
}

class EulaPath extends MainPath{
  @override
  final path = '/eula';
}

class LoginPath extends MainPath{
  @override
  final path = '/login';
}

class AppPath extends MainPath{
  @override
  final path = '/app';
  String innerPath;
  AppPath(this.innerPath);
}

class MainDelegate extends RouterDelegate<MainPath>
  with ChangeNotifier, PopNavigatorRouterDelegateMixin<MainPath>
{

  static String _home = '/eula';
  static set home(String home) => _home = home;

  static final mainKey = GlobalKey<MainProgramState>();
  static final authKey = GlobalKey<AuthorizationState>();

  static final _authorization = Authorization(key: authKey);

  late SettingsRouter _settingsRouter;

  MainPath _path;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MainDelegate() : navigatorKey = GlobalKey<NavigatorState>(), _path = _parseInfoStr('/home')
  {
    _settingsRouter = SettingsRouter(()=>_path.settings!, (settings) => _path.settings = settings);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages:[
        CupertinoPage(child: _getWidgetFromPath(_path), name: _path.path),
        if(_path.settings != null) ..._settingsRouter.getPages(_path.settings!),
      ],
      onPopPage: (route, result){
        if(_path.settings != null)
        {
          if(_path.settings!.fastReturn || _path.settings!.path == '/')
          {
            _path.settings = null;
          }
          else
          {
            var paths = _path.settings!.path.split('/')
              ..removeLast();

            if(paths.isNotEmpty)
            {
              _settingsRouter.SetPath('/'+paths.join('/'));
            }
            else
            {
              _settingsRouter.SetPath('/');
            }
          }
        }
        notifyListeners();
        return route.didPop(result);},
    );
  }

  Widget _getWidgetFromPath(MainPath path){

    if(path is LoginPath) {
      return _authorization;
    } else if(path is AppPath) {
      return MainProgram(key: mainKey, route: path);
    }
    return Eula();

  }

  @override
  Future<void> setNewRoutePath(MainPath configuration) async {
    _path = configuration;
  }

  void SetPath(String path){
    if(!path.startsWith('/settings')){
      _path = _parseInfoStr(path);
    }
    else{
      var uri = Uri.parse(path);
      _path.settings = SettingsRouter.resolve('/' + (uri.pathSegments.length > 1 ? uri.pathSegments.sublist(1).join('/') : ''));
    }
    notifyListeners();
  }

}

MainPath _parseInfoStr(String? location){
  final uri = Uri.parse(location ?? '/home');

    if(uri.pathSegments.isEmpty || uri.pathSegments.first == 'home'){
      return _parseInfoStr(MainDelegate._home + (uri.pathSegments.length > 1 ? '/${ uri.pathSegments.sublist(1).join('/')}' : ''));
    }

    switch(uri.pathSegments.first){
      case 'login':
        return LoginPath();
      case 'app':
        return AppPath(uri.pathSegments.isEmpty ? '' : '/' + uri.pathSegments.sublist(1).join('/'));
      case 'eula':
      default:
        return EulaPath();
    }
}

class MainRouterInformationParser extends RouteInformationParser<MainPath>
{
  @override
  Future<MainPath> parseRouteInformation(RouteInformation routeInformation) async
  {
    return _parseInfoStr(routeInformation.location);
  }

  @override
  RouteInformation? restoreRouteInformation(MainPath configuration) {
    
    if(MainPath is AppPath) {
      return RouteInformation(location: configuration.path + '/${(configuration as AppPath).innerPath}');
    }

    return RouteInformation(location: configuration.path);

  }
  
}
