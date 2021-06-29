import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/MainProgram.dart';
import 'package:vesta/applicationpage/calendar/calendarDataDetailedDisplay.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:intl/intl.dart';

class CalendarBody extends StatelessWidget{
  
  final CalendarData _data;
  final timeFormat = DateFormat('HH:mm');
  final dayFormat = DateFormat('(yyyy. MM. dd.)');

  CalendarBody(CalendarData data) : _data = data;

  String _formatDate(CalendarData data)
  {
    return '${timeFormat.format(data.start)} - ${timeFormat.format(data.end)} ${dayFormat.format(data.end)}';
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ()=> MainProgram.of(context).parentNavigator.push(MaterialPageRoute(
              builder: (BuildContext context){
                return LessonDetailedDisplay(_data);
              }
              )
            ),
            child: Column(
              children : [ ListTile(
                  title: Text( _data.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  subtitle: Text('location: ${_data.location}'),
                  onTap: null
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom:20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_formatDate(_data)),
                      Container(
                        padding: EdgeInsets.only(left:10),
                        child: Icon(_data.type.icon, color: _data.eventColor, size: 30,),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

}