import 'package:vesta/web/webdata/iWebData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

abstract class WebDataContainer extends IWebData
{

  final int? LCID;
  final int? CurrentPage;

  WebDataBase get base;

  WebDataContainer({this.LCID, this.CurrentPage});

  @override
  Map<String, dynamic> toJsonMap()
  {
    var bas = base.toJsonMap();
    if(LCID != null)
    {
      bas['LCID'] = LCID;
    }
    if(CurrentPage != null)
    {
      bas['CurrentPage'] = CurrentPage;
    }
    return bas;
  }
}

class SimpleConatiner extends WebDataContainer
{
  @override
  final WebDataBase base;

  SimpleConatiner(this.base, {int? LCID, int? CurrentPage}) 
    : super(LCID: LCID, CurrentPage: CurrentPage);
  
  @override
  Map<String, dynamic> toJsonMap() => super.toJsonMap();

  factory SimpleConatiner.fromJson(Map<String, dynamic> json)
  {
    var base = WebDataBase.fromJson(json);
    return SimpleConatiner(base);
  }
  
}