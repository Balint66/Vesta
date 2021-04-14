part of '../pageSettingsBase.dart';

class CalendarPageSettings extends PageSettingsBase<CalendarPageData>
{

  CalendarPageSettings(String page, PageSettingsData data) : super._(page, data as CalendarPageData);

  @override
  PageSettingsState<PageSettingsBase> createState() => CalendarPageSettingsState();
    
}

class CalendarPageSettingsState extends PageSettingsState<CalendarPageSettings>
{
  @override
  List<BuildFunction> get body
  {
    var base = super.body;
    base.add((conetxt){
      return PopupMenuButton(itemBuilder:
        (context)=>CalendarDisplayModes.values
          .map((e)=>PopupMenuItem<int>( value:e.index, child: Text(e.displayName))).toList(),
        onSelected: (int value)
        {
          setState((){
            widget.data!.mode = CalendarDisplayModes.values[value];
            Vesta.of(context).updatePageSettings(widget.page, widget.data!);
          });
        },
        child: ListTile(title: Text('Mode: ${widget.data!.mode.displayName}'),)
      );
    });
    return base;
  }
}