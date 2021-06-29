import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vesta/utils/DateUtil.dart';

/*
    type 0: óra
    type 1: vizsga
    type 2: feladatok
    type 3: Találkozó/Egyéni
    type 4: Feliratkozások
    type 5: Konzultációk
    type 6: oktató mentessítések
    type 7: szünnapok
    type 8: intézmény
   */
enum EventType
{
  LESSON,
  EXAM,
  TASK,
  CUSTOM,
  SUBSCRIPTION,
  CONSULTING,
  FREED,
  HOLIDAY,
  INSTITUTION
}

Map<EventType, IconData> icons = <EventType, IconData>{
  EventType.LESSON: FeatherIcons.bookOpen,
  EventType.EXAM: FeatherIcons.penTool,
  EventType.TASK: FeatherIcons.list,
  EventType.CUSTOM: FeatherIcons.hexagon,
  EventType.SUBSCRIPTION: FeatherIcons.star,
  EventType.CONSULTING: FeatherIcons.messageSquare,
  EventType.FREED: Icons.free_breakfast,
  EventType.HOLIDAY: FeatherIcons.home,
  EventType.INSTITUTION: Icons.school,
};

extension TypeIcons on EventType{
  IconData get icon => icons[this] as IconData;
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
  final EventType type;

  CalendarData({bool isAllDay = false, String description = '', DateTime? end,
    Color color = Colors.black, String id = '0', String location = '',
    DateTime? start, String title = '', EventType type = EventType.LESSON})
      : allDayLong = isAllDay, description = description,
        end = end ?? DateTime(0).add(Duration(hours: 4, minutes: 30)),
        start = start ?? DateTime(0), eventColor = color,
        id = id, location = location, title = title, type = type;

  CalendarData.fromJsonString(String jsonString)
      : this.fromJson(json.decode(jsonString));

  CalendarData.fromJson(Map<String, dynamic> jsonMap)
      : this(isAllDay: jsonMap['allDayLong'], description: jsonMap['description'],
      end: _getEndDate(
          int.tryParse(jsonMap['start'].toString().split('(')[1].split(')')[0]) ?? 0,
          int.tryParse(jsonMap['end'].toString().split('(')[1].split(')')[0]) ?? 0),
      color: Color.fromARGB((jsonMap['eventColor'] as Map<String, dynamic>)['a'],
          (jsonMap['eventColor'] as Map<String, dynamic>)['r'],
          (jsonMap['eventColor'] as Map<String, dynamic>)['g'],
          (jsonMap['eventColor'] as Map<String, dynamic>)['b']),
      id:jsonMap['id'].toString(), location:jsonMap['location'],
      start:DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(jsonMap['start'].toString().split('(')[1].split(')')[0]) ?? 0, isUtc: true),
      title:jsonMap['title'], type: EventType.values[(jsonMap['type'] as int)]);

  static DateTime _getEndDate(int start, int neptunEnd)
  {
    var startTime = DateTime.fromMillisecondsSinceEpoch(start);
    var neptunEndTime = DateTime.fromMillisecondsSinceEpoch(neptunEnd);

    var realEnd = DateUtil.epochFlooredToDays(startTime)
      + (neptunEndTime.millisecondsSinceEpoch
            - DateUtil.epochFlooredToDays(neptunEndTime));

    return DateTime.fromMillisecondsSinceEpoch(realEnd, isUtc: true);

  }

  @override
  bool operator ==(Object other) {
    return other is CalendarData && other.id == id ;
  }

}