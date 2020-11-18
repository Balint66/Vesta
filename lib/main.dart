import 'package:universal_io/io.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:vesta/Vesta.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

void main() async
{

  var alpha = Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  if(alpha)
  {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }

  WebServices.init();

  runApp(Vesta());
  

  if(Platform.isAndroid)
  {
    await BackgroundFetch.registerHeadlessTask(FetchManager.fetch);
  }

}
