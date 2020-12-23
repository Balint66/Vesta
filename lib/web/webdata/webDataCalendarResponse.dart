import 'dart:convert';

import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCalendarResponse extends WebDataBase
{

  final BaseDataList<CalendarData> calendarData;

  WebDataCalendarResponse(StudentData data, List<CalendarData> calendarData)
      : calendarData = BaseDataList(other: calendarData),  super.studentSimplified(data);

  WebDataCalendarResponse.fromJsonString(String string) : this.fromJson(json.decode(string));

  WebDataCalendarResponse.fromJson(Map<String, dynamic> map) : this(StudentData.fromJsondata(map),((map['calendarData'] as List).isNotEmpty)?
      BaseDataList(other: List.generate((map['calendarData'] as List<dynamic>).length, (index)
      {
        return CalendarData.fromJson((map['calendarData'] as List<dynamic>)[index] as Map<String, dynamic>);
      })): BaseDataList<CalendarData>());
  

}
