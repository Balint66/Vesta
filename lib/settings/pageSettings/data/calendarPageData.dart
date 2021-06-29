import 'package:vesta/applicationpage/calendar/calendarDataDisplay.dart';
import 'package:vesta/datastorage/Lists/holder/listDataHolder.dart';
import 'package:vesta/settings/pageSettingsData.dart';

class CalendarPageData extends PageSettingsData
{

  @override
  var interval = CalendarListHolder.defaultInterval;
  var mode = CalendarDisplayModes.LISTVIEW;

  CalendarPageData();

  factory CalendarPageData.fromJson(Map<String, dynamic> fromJson)
  {
    var data = CalendarPageData();
    data.mode = CalendarDisplayModes.values[fromJson['mode']];
    return data;
  }

  @override
  Map<String, dynamic> toJson() {
    var base = super.toJson();
    base['type'] = 'calendar';
    base['mode'] = mode.index;
    return base;
  }

}