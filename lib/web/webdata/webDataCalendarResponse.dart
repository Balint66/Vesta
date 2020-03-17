import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCalendarResponse extends WebDataBase
{

  final List<CalendarData> calendarData;

  WebDataCalendarResponse(StudentData data, List<CalendarData> calendarData)
      : this.calendarData = calendarData,  super.studentSimplified(data);

  WebDataCalendarResponse.fromJsonString(String string) : this.fromJson(json.decode(string));

  WebDataCalendarResponse.fromJson(Map<String, dynamic> map) : this(StudentData.fromJsondata(map),((map["calendarData"] as List).length > 0)?
      List.generate((map["calendarData"] as List<dynamic>).length, (index)
      {
        return CalendarData.fromJson((map["calendarData"] as List<dynamic>)[index] as Map<String, dynamic>);
      }): new List(0));
  

}

class CalendarData
{

  final bool allDayLong;
  final String description;
  final DateTime end;
  final Color eventColor;
  final String id;
  final String location;
  final DateTime start;
  final String title;
  final String type;

  CalendarData({bool isAllDay = false, String description = "", DateTime end,
    Color color = Colors.black, String id = "0", String location = "",
    DateTime start, String title = "", String type = "0"})
      : this.allDayLong = isAllDay, this.description = description,
        this.end = end != null ? end : DateTime.now().add(Duration(hours: 4, minutes: 30)),
        this.start = start != null ? start : DateTime.now(), this.eventColor = color,
        this.id = id, this.location = location, this.title = title, this.type = type;

  CalendarData.fromJsonString(String jsonString)
      : this.fromJson(json.decode(jsonString));

  CalendarData.fromJson(Map<String, dynamic> jsonMap)
      : this(isAllDay: jsonMap["allDayLong"], description: jsonMap["description"],
              end: DateTime.fromMicrosecondsSinceEpoch(
                  int.tryParse(jsonMap["end"].toString().split("(")[1].split(")")[0])),
        color: Color.fromARGB( (jsonMap["eventColor"] as Map<String, dynamic>)["a"],
            (jsonMap["eventColor"] as Map<String, dynamic>)["r"],
            (jsonMap["eventColor"] as Map<String, dynamic>)["g"],
            (jsonMap["eventColor"] as Map<String, dynamic>)["b"]),
          id:jsonMap["id"].toString(), location:jsonMap["location"],
          start:DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(jsonMap["start"].toString().split("(")[1].split(")")[0])),
          title:jsonMap["title"], type: jsonMap["type"].toString());

}
