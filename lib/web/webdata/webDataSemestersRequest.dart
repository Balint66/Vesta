import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSemestersRequest extends WebDataBase
{

  final int PeriodTermID;

  WebDataSemestersRequest(StudentData data, {int PeriodTermID = 0}) : this.PeriodTermID = PeriodTermID, super.studentSimplified(data);

  @override
  Map<String, dynamic> toJsonMap()
  {
    Map<String, dynamic> data = <String,dynamic>
    {
      "PeriodTermID": PeriodTermID
    };

    data.addAll(super.toJsonMap());

    return data;

  }

}