import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/common/popupOptionProvider.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/routing/replacementObserver.dart';

class PopupSettings extends StatefulWidget
{

  PopupSettings({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState()
  {
      return new PopupSettingsState();
  }
  
}

class PopupSettingsState extends State<PopupSettings> with PopupOptionProvider
{

  @override
  Widget build(BuildContext context)
  {

    Vesta.logger.d("May I get a rebuild?");

    var _currentPath = ReplacementObserver.Instance.currentPath;

      List<PopupMenuEntry<int>> entries = new List();

      entries.add(new CheckedPopupMenuItem<int>(
        value: 0,
        checked: ("/" + _currentPath.split('/')[2]) == Vesta.of(context).settings.appHomePage,
        child: new Text(AppTranslations.of(context).translate("popup_app_home")),
        )
      );

    var external = _popupData.builder.call(context);

    if(external != null)
      entries.addAll(external);

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
              _popupData.selector.call(value);
              break;
          }
      };

      return new PopupMenuButton(
        itemBuilder: (BuildContext ctx) => entries,
        onSelected: selected,
      );      
  }

  PopupOptionData _popupData = new PopupOptionData(builder: (BuildContext context)=> null, selector: (int i)=> null);

  @override
  PopupOptionData getOptions() 
  {
    return _popupData;
  }

  @override
  void setOptions(builder, selector) 
  {
    setState(() {
      _popupData = new PopupOptionData(builder: builder, selector: selector);  
    });  
  }

}
