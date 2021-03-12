import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataCalendarResponse extends WebDataContainer
{

  final BaseDataList<CalendarData> calendarData;
  @override
  final WebDataBase base;

  WebDataCalendarResponse(this.base, List<CalendarData> calendarData)
      : calendarData = BaseDataList(other: calendarData);

  factory WebDataCalendarResponse.fromJson(Map<String, dynamic> map){
    var data = (map['calendarData'] as List).isNotEmpty ?
    BaseDataList(other: List.generate((map['calendarData'] as List<dynamic>).length, (index)
    {
      return CalendarData.fromJson((map['calendarData'] as List<dynamic>)[index] as Map<String, dynamic>);
    })): BaseDataList<CalendarData>();
    var base = WebDataBase.fromJson(map);
    return WebDataCalendarResponse(base, data);
  }

  @override
  Map<String, dynamic> toJsonMap() 
  {
    throw UnimplementedError();
  }
  

}
