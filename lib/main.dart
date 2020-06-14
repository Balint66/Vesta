import 'package:universal_io/io.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:vesta/Vesta.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

void main() async
{

  try
  {
    if(!(Platform.isAndroid || Platform.isIOS || Platform.isFuchsia))
    {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
    }
  }
  catch(e){}

  WebServices.init();

  await runApp(new Vesta());
  
  try
  {

    if(Platform.isAndroid)
    {
      BackgroundFetch.registerHeadlessTask(FetchManager.fetch);
    }

  }
  catch(e){}
}
