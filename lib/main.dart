import 'package:universal_io/io.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:vesta/Vesta.dart';
import 'package:vesta/managers/appStateManager.dart';
import 'package:vesta/web/fetchManager.dart';

void main() async
{

  if(Platform.isWindows || Platform.isLinux || Platform.isMacOS) //changehow flutter acts on these platforms
  {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }
  
  var manager = AppStateManager();

  await manager.init();

  runApp(Vesta(manager));
  

  if(Platform.isAndroid)
  {
    await BackgroundFetch.registerHeadlessTask(FetchManager.fetch);
  }

}
