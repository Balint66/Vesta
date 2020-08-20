import 'package:vesta/settings/pageSettings/data/messagePageData.dart';

abstract class PageSettingsData 
{
  bool isEnabled = true;
  Duration get interval;
  set interval(Duration value);

  PageSettingsData();

  factory PageSettingsData.fromJson(Map<String, dynamic> fromJson)
  {
    PageSettingsData data;
    switch(fromJson['type'])
    {
      case 'messages':
      default:
        data = MessagePageData.fromJson(fromJson);
        break;
    }

    return PageSettingsData.loadfromJson(data, fromJson);

  }

  Map<String, dynamic> toJson()
  {
    return <String, dynamic>{
      'type': '',
      'isEnabled':isEnabled,
      'interval': interval.toString()
    };
  }

  static PageSettingsData loadfromJson(PageSettingsData data, Map<String, dynamic> toJson)
  {
    data.isEnabled = toJson['isEnabled'];
    var ls = toJson['interval'].toString().split(':').expand((element) => element.split('.')).toList();
    data.interval = Duration(hours: int.parse(ls[0]), minutes: int.parse(ls[1]), seconds: int.parse(ls[2]), microseconds: int.parse(ls[3]));
    return data;
  }

}