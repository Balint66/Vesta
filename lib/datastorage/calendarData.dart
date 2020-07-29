import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vesta/utils/DateUtil.dart';

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

  CalendarData({bool isAllDay = false, String description = '', DateTime end,
    Color color = Colors.black, String id = '0', String location = '',
    DateTime start, String title = '', String type = '0'})
      : allDayLong = isAllDay, description = description,
        end = end ?? DateTime.now().add(Duration(hours: 4, minutes: 30)),
        start = start ?? DateTime.now(), eventColor = color,
        id = id, location = location, title = title, type = type;

  CalendarData.fromJsonString(String jsonString)
      : this.fromJson(json.decode(jsonString));

  CalendarData.fromJson(Map<String, dynamic> jsonMap)
      : this(isAllDay: jsonMap['allDayLong'], description: jsonMap['description'],
      end: _getEndDate(
          int.tryParse(jsonMap['start'].toString().split('(')[1].split(')')[0]),
          int.tryParse(jsonMap['end'].toString().split('(')[1].split(')')[0])),
      color: Color.fromARGB((jsonMap['eventColor'] as Map<String, dynamic>)['a'],
          (jsonMap['eventColor'] as Map<String, dynamic>)['r'],
          (jsonMap['eventColor'] as Map<String, dynamic>)['g'],
          (jsonMap['eventColor'] as Map<String, dynamic>)['b']),
      id:jsonMap['id'].toString(), location:jsonMap['location'],
      start:DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(jsonMap['start'].toString().split('(')[1].split(')')[0])),
      title:jsonMap['title'], type: jsonMap['type'].toString());

  static DateTime _getEndDate(int start, int neptunEnd)
  {
    var startTime = DateTime.fromMillisecondsSinceEpoch(start);
    var neptunEndTime = DateTime.fromMillisecondsSinceEpoch(neptunEnd);

    var realEnd = DateUtil.epochFlooredToDays(startTime)
      + (neptunEndTime.millisecondsSinceEpoch
            - DateUtil.epochFlooredToDays(neptunEndTime));

    return DateTime.fromMillisecondsSinceEpoch(realEnd);

  }

}