import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:vesta/Vesta.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

void main() async
{

  debugDefaultTargetPlatformOverride = TargetPlatform.android;

  WebServices.init();

  runApp(new Vesta());
  BackgroundFetch.registerHeadlessTask(FetchManager.fetch);

  FetchManager.stopFrontFetch();

}
