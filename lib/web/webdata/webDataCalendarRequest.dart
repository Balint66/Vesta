import 'package:vesta/datastorage/studentData.dart';
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
          DateTime starDate, DateTime endDate, int entityLimit = 0})
      : this.Time = time, this.Exam = exam, this.Task = task,
        this.Apointment = appointment, this.needAllDayLong = needAllDayLong,
        this.RegisterList = registerList, this.Consulation = consulation,
        this.startDate = starDate != null ? starDate: DateTime.now(),
        this.endDate = endDate != null? starDate : DateTime.now().add(Duration(days: 7)),
        this.entityLimit = entityLimit,
        super.studentSimplified(data);


  @override
  Map<String, dynamic> toJsonMap() {
    Map<String, dynamic> map = <String,dynamic>
    {
      "needAllDayLong":needAllDayLong, "Time":Time,
      "Exam":Exam, "Task": Task, "Apointment":Apointment,
      "RegisterList": RegisterList,
      "Consulation": Consulation, "startDate": "\/Date(" + startDate.millisecondsSinceEpoch.toString() + ")\/",
      "endDate": "\/Date(" + endDate.millisecondsSinceEpoch.toString() + ")\/"
    };
    map.addAll(super.toJsonMap());
    return map;
  }


}