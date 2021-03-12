import 'package:vesta/web/webdata/webDataContainer.dart';
import 'package:vesta/web/webdata/iWebData.dart';
import 'webDataBase.dart';

class WebDataLogin extends WebDataContainer
{

  @override
  final WebDataBase base;

  // ignore: non_constant_identifier_names
  final bool OnlyLogin;

  // ignore: non_constant_identifier_names
  WebDataLogin(String UserLogin, String Password,
      {int? LCID, this.OnlyLogin = false}) : base= WebDataBase(UserLogin, // ignore: non_constant_identifier_names
      Password, null, null, LCID:LCID,);

  WebDataLogin.fromJson(Map<String, dynamic> json) : OnlyLogin = json['OnlyLogin'], base = WebDataBase.fromJson(json.mapRemove('OnlyLogin') );

  @override
  Map<String, dynamic> toJsonMap()
  {

    var map = <String,dynamic>{
      'OnlyLogin':OnlyLogin
    };

    map.addAll(base.toJsonMap());

    return map;

  }

}