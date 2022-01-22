import 'dart:async';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/i18n/localizedApp.dart';
import 'package:vesta/managers/settingsManager.dart';
import 'package:vesta/managers/logManager.dart';
import 'package:vesta/managers/messageManager.dart';
import 'package:vesta/routing/router.dart';
import 'package:vesta/settings/pageSettingsData.dart';
import 'package:vesta/utils/ColorUtils.dart';
import 'package:vesta/utils/ColoredThemeData.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:intl/intl.dart';

import 'managers/appStateManager.dart';


class Vesta extends StatefulWidget
{
  
  static var home = '/login';
  
  static Logger get logger => LogManager.logger;
  static final showSnackbar = (Widget widget)=>MessageManager.showSnackBar(widget);
  static final dateFormatter = DateFormat('yy. MM. dd. HH:mm');

  final AppStateManager appManager;

  Vesta(this.appManager);

  @override
  State<StatefulWidget> createState()
  {
    return VestaState();
  }

  static VestaState of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<_VestaInherited>()!.data!;
  }

}

class _VestaInherited extends InheritedWidget
{

  _VestaInherited({Key? key, @required Widget? child, @required VestaState? data}) :
        data = data ,super(key: key, child: child ?? Container());

  final VestaState? data;

  @override
  bool updateShouldNotify(_VestaInherited oldWidget) {
    return true;
  }

}

class VestaState extends State<Vesta> with WidgetsBindingObserver
{

  final routerDelegate = MainDelegate();
  final _routerInformationParser = MainRouterInformationParser();

  @override
  void initState()
  {
    super.initState();
    SettingsManager.INSTANCE.addListener(()=>setState((){}));
    application.addListener(onLocaleChanged);

    application.changeLocal(application.supportedLocales().where((element) 
        => element.languageCode == SettingsManager.INSTANCE.settings.language).first);

    _post = widget.appManager.appInit();

    WidgetsBinding.instance?.addObserver(this);

  }

  @override
  void dispose()
  {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) 
  {
    super.didChangeAppLifecycleState(state);

    switch(state)
    {
      case AppLifecycleState.paused:
        FetchManager.stopFrontFetch();
        break;
      case AppLifecycleState.resumed:
        FetchManager.startFrontFetch();
        break;
      default:
        return;
    }

  }

  void onLocaleChanged()
  {
    setState(() {
      AppTranslations.load(application.appDelegate.newLocale ?? Locale('en', 'US'));
    });
  }

  bool get pageSettingsChanged => _pagesettings;
  void resetpageChange() => _pagesettings = false;
  bool _pagesettings = false;

  void manuallySetPageChange() => setState((){ _pagesettings = true;});

  void updatePageSettings(String page, PageSettingsData data)
  {

    if(!SettingsManager.INSTANCE.settings.pageSettings.containsKey(page)){
      return;
    }

    setState(() {
      SettingsManager.INSTANCE.updatePageSettings(page, data);
      _pagesettings = true;
    });

  }

  Future<bool>? _post;

  @override
  Widget build(BuildContext context)
  {
      return FutureBuilder(future:_post,
          builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot)
          {

            if(!snapshot.hasData && !snapshot.hasError && snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasError && !(snapshot.error is MissingPluginException)) {
              Vesta.logger.e('It wasn\'t me! I swear...', snapshot.error, snapshot.stackTrace );
            }

            if(!snapshot.hasError && (snapshot.data ?? false)){
              Vesta.home = '/app/home';
            }

          return I18n(child: OverlaySupport(
              child: _VestaInherited(
                data: this,
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Vesta',
                  theme: ColoredThemeData.create(
                        MaterialColor(SettingsManager.INSTANCE.settings.mainColor.value, genSwatch()),
                        Brightness.light,
                    ),
                    darkTheme: ColoredThemeData.create(
                      MaterialColor(SettingsManager.INSTANCE.settings.mainColor.value, genSwatch()),
                      Brightness.dark,
                    ),
                    localizationsDelegates: 
                    [
                      application.appDelegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    supportedLocales: [
                      Locale('en'),
                      Locale('hu')
                    ],
                    themeMode: SettingsManager.INSTANCE.settings.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
                    routerDelegate: routerDelegate,
                    routeInformationParser: _routerInformationParser,
                  )
                )
              ))
          ;}
      );

  }

  Map<int, Color> genSwatch()
  {
      var stringSwatch = ColorUtils.swatchColor(ColorUtils.intToHex(SettingsManager.INSTANCE.settings.mainColor.value));

      var map = <int, Color>{};

      for(var i = 0; i < stringSwatch.length; i++)
      {
        if(i == 0)
        {
          map.putIfAbsent(50, () => Color(ColorUtils.hexToInt(stringSwatch[i])));
        }
        else
        {
          map.putIfAbsent(100 * i, () => Color(ColorUtils.hexToInt(stringSwatch[i])));
        }
      }

      return map;

  }

}