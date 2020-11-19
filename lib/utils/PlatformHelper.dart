import './nonePlatformHelper.dart' 
  if(dart.library.html) './webPlatformHelper.dart'
  if(dart.library.io) './ioPlatformHelper.dart' as platform;

abstract class PlatformHelper 
{

  static bool isWeb() => platform.isWeb();
  
}