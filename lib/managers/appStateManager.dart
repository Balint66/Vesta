import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';
import 'package:vesta/datastorage/local/persistentDataManager.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

class AppStateManager extends ChangeNotifier
{
  Future<void> init() async
  {
    WebServices.init();
    FetchManager.init();
  }

  Future<bool> appInit() async
  {
    await _initPlatform();
    await FileManager.init();
    SettingsManager.INSTANCE.loadSettings();
    MainProgRouter.defaultRoute = '/app' + SettingsManager.INSTANCE.settings.appHomePage;
    var validData = await FileManager.readData();
    if(SettingsManager.INSTANCE.settings.eulaAccepted)
    {
      if(validData)
      {
        MainDelegate.home = MainProgRouter.defaultRoute;
      }
      else
      {
        MainDelegate.home = '/login';
      }
    }
    return validData;
  }

  Future<void> _initPlatform() async
  {
    try
    {
      if( Platform.isAndroid || Platform.isIOS) {
        await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiredNetworkType: NetworkType.ANY,
      ), (String id) async
      {
        await FetchManager.fetch();
        BackgroundFetch.finish(id);
      });
      }
    }
    catch(e)
    {
      Vesta.logger.w('Dabiri-dabirido! What does this button do?\n Unable to configure background fetch. Something is not implemented?', e);
    }
  }

}