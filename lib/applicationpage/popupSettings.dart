import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/routing/replacementObserver.dart';

class PopupSettings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
      return new PopupSettingsState();
  }
  
}

class PopupSettingsState extends State<PopupSettings>
{

  Map<String, PopupMenuItemBuilder<int>> builders = <String, PopupMenuItemBuilder<int>>{
    "/app/messages": (BuildContext context)
    {
      return null;
    },
    "/app/calendar": (BuildContext context)
    {
      return null;
    }
  };

  Map<String, PopupMenuItemSelected<int>> selectors = <String, PopupMenuItemSelected<int>>
  {
    "/app/messages": (int value){},
    "/app/calendar" : (int value){}
  };

  String _currentPath = ReplacementObserver.Instance.currentPath;

  @override
  void initState()
  {
    super.initState();

    Future.doWhile(() async
    {
      await Future.delayed(new Duration(seconds: 1));

      if(_currentPath != ReplacementObserver.Instance.currentPath)
      {
        setState(()
        {
          _currentPath = ReplacementObserver.Instance.currentPath;
        });
      }

      return true;

    } );

  }

  @override
  Widget build(BuildContext context)
  {

      List<PopupMenuEntry<int>> entries = new List();

      entries.add(new CheckedPopupMenuItem<int>(
        value: 0,
        checked: ("/" + _currentPath.split('/')[2]) == Vesta.of(context).settings.appHomePage,
        child: new Text(AppTranslations.of(context).translate("popup_app_home")),
        )
      );

      List<PopupMenuEntry<int>> fromBuilder = builders[_currentPath].call(context);

      if(fromBuilder != null)
        entries.addAll(fromBuilder);

      PopupMenuItemSelected<int> selected = (int value)
      {
          switch(value)
          {
            case 0:
              setState(() {
                Vesta.of(context).updateSettings(route: _currentPath);
              });
              break;
            default:
              this.selectors[_currentPath].call(value);
              break;
          }
      };

      return new PopupMenuButton(
        itemBuilder: (BuildContext ctx) => entries,
        onSelected: selected,
      );
  }

}
