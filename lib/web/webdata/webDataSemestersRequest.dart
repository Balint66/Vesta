import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataSemestersRequest extends WebDataBase
{

  final int PeriodTermID;

  WebDataSemestersRequest(AccountData data, {int PeriodTermID = 0}) : PeriodTermID = PeriodTermID, super.studentSimplified(data);

  @override
  Map<String, dynamic> toJsonMap()
  {
    var data = <String,dynamic>
    {
      'PeriodTermID': PeriodTermID
    };

    data.addAll(super.toJsonMap());

    return data;

  }

}