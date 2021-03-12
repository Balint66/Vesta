import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/applicationpage/lessons/lessonDisplay.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/settings/pageSettings/data/calendarPageData.dart';
import 'package:vesta/settings/pageSettings/data/messagePageData.dart';
import 'package:vesta/settings/pageSettingsData.dart';

part './pageSettings/messagePageSettings.dart';
part './pageSettings/calendarPageSettings.dart';

abstract class PageSettingsBase<T extends PageSettingsData> extends StatefulWidget
{

  final String page;
  final T? data;

  factory PageSettingsBase(String page, PageSettingsData? data)
  {
    switch(page)
    {
      case 'calendar':
        return CalendarPageSettings(page, data ?? CalendarPageData()) as PageSettingsBase<T>;
      case 'messages':
        return MessagePageSettings(page, data ?? MessagePageData()) as PageSettingsBase<T>;
      default:
        return _Empty(page);
    }
  }

  PageSettingsBase._(this.page, this.data);

  @override
  PageSettingsState createState();

}

class _Empty<T extends PageSettingsData> extends PageSettingsBase<T>
{

  _Empty(String page) : super._(page, null);

  @override
  _EmptyState createState() => _EmptyState();

}

class _EmptyState extends PageSettingsState
{
  
  @override
  List<BuildFunction> get body => [];

  @override
  Widget build(BuildContext context) //ignore:invalid_override_of_non_virtual_member
  {
    var translator = AppTranslations.of(context);
    return Scaffold(appBar: AppBar(title: Text(translator.translate('sidebar_' + widget.page)),), body: Container());
  }
}

typedef BuildFunction = Widget Function(BuildContext context);

abstract class PageSettingsState<T extends PageSettingsBase> extends State<T>
{

  @mustCallSuper
  List<BuildFunction> get body=> [
    (context) => SwitchListTile( title: Text((AppTranslations.of(context).translateRaw('settings_page')['common']['enabled']?.toString()) ?? ''), value: widget.data?.isEnabled ?? false, onChanged: (value)
    {
      if(widget.data != null)
      {
        setState((){
          widget.data!.isEnabled = !(widget.data!.isEnabled);
          Vesta.of(context).updatePageSettings(widget.page, widget.data!);
        });
      }
    }),
    (context) => ListTile(
      title: Text('${AppTranslations.of(context).translateRaw('settings_page')['common']['interval']} : ${widget.data?.interval.inMinutes}m',
      style: TextStyle(color: !(widget.data?.isEnabled ?? false) ? Theme.of(context).disabledColor : Theme.of(context).textTheme.bodyText1!.color )),
    onTap: !(widget.data?.isEnabled ?? true) ? null : () async
    {
      Duration? dur = await showDurationPicker(context: context, initialTime: widget.data?.interval, snapToMins: 1);
      
      if(dur != null && widget.data != null)
      {
        setState(() {
          widget.data!.interval = dur;
          Vesta.of(context).updatePageSettings(widget.page, widget.data!);
        });
      }

    })
  ];

  @nonVirtual
  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);

    return  Scaffold(appBar: AppBar(title: Text(translator.translate('sidebar_' + widget.page)),),
      body: ListView(children: (body.map((e) => e.call(context)).toList().cast())),
    );
  }

}