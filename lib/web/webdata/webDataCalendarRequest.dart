import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/utils/DateUtil.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataCalendarRequest extends WebDataBase
{

  final bool needAllDayLong;
  final bool Time; // ignore: non_constant_identifier_names
  final bool Exam; // ignore: non_constant_identifier_names
  final bool Task; // ignore: non_constant_identifier_names
  final bool Apointment; // ignore: non_constant_identifier_names
  final bool RegisterList; // ignore: non_constant_identifier_names
  final bool Consulation; // ignore: non_constant_identifier_names
  final DateTime startDate;
  final DateTime endDate;
  final int entityLimit;

  WebDataCalendarRequest(StudentData data, {bool needAllDayLong = false ,bool time = true, bool exam = true, bool task = true,
          bool appointment = true, bool registerList = true, bool consulation = true,
          DateTime? starDate, DateTime? endDate, int entityLimit = 0})
      : Time = time, Exam = exam, Task = task,
        Apointment = appointment, needAllDayLong = needAllDayLong,
        RegisterList = registerList, Consulation = consulation,
        startDate = starDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now().add(Duration(days: 7)),
        entityLimit = entityLimit,
        super.studentSimplified(data);


  @override
  Map<String, dynamic> toJsonMap() {
    var map = <String,dynamic>
    {
      'needAllDaylong':needAllDayLong,
      'Time':Time,
      'Exam':Exam,
      'Task': Task,
      'Apointment':Apointment,
      'RegisterList': RegisterList,
      'Consulation': Consulation, 'startDate': '\/Date('
          + DateUtil.epochFlooredToDays(startDate).toString() + ')\/',
      'endDate': '\/Date('
          + DateUtil.epochFlooredToDays(endDate).toString() + ')\/',
      'entityLimit': entityLimit
    };
    map.addAll(super.toJsonMap());
    return map;
  }


}