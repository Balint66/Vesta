import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataSemestersRequest extends WebDataContainer
{

  @override
  final WebDataBase base;

  final int PeriodTermID;

  WebDataSemestersRequest(this.base, {int PeriodTermID = 0}) : PeriodTermID = PeriodTermID;

  @override
  Map<String, dynamic> toJsonMap()
  {
    var data = <String,dynamic>
    {
      'PeriodTermID': PeriodTermID
    };

    data.addAll(base.toJsonMap());

    return data;

  }

}