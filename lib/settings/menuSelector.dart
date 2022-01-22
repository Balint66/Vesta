import 'package:flutter/material.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/settingsManager.dart';

class MenuSelector extends StatefulWidget
{

  final String _initialValue;

  MenuSelector(this._initialValue);

  @override
  State<StatefulWidget> createState() => MenuSelectorState(); 

}

class MenuSelectorState extends State<MenuSelector>
{

  String _home = '';

  @override
  void initState() {
    super.initState();

    _home = widget._initialValue.substring(1);

  }

  @override
  Widget build(BuildContext context)
  {

    var translator = AppTranslations.of(context);

    return ExpansionTile(leading: Icon(Icons.home_outlined), title: Text((translator.translate('popup_app_home')) + ': ' + (translator.translate('sidebar_' + _home))), 
      children:<Widget>[_item('messages', translator), _item('forum', translator), _item('calendar', translator), 
      _item('subjects', translator), _item('exams', translator),
      _item('student_book', translator), _item('semesters', translator)]);
  }

  Widget _item(String str, translator)
  {
    return RadioListTile<String>(value: str, groupValue: _home, title: Text(translator.translate('sidebar_$str')), 
      onChanged: (i)=> setState((){_home = i as String; SettingsManager.INSTANCE.updateSettings(route: '/app/'+_home);}));
  }

}