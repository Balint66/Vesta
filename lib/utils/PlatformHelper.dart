import 'package:universal_io/io.dart';

abstract class PlatformHelper 
{

  factory PlatformHelper._() => null;


  static bool isWeb()
  {
    return Platform.operatingSystem == '' || Platform.operatingSystem == 'Web' || Platform.operatingSystem == 'web';
  }


}