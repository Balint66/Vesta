import 'package:vesta/datastorage/studentData.dart';
import 'webDataBase.dart';

class WebDataLogin extends WebDataBase
{


  // ignore: non_constant_identifier_names
  final bool OnlyLogin;

  // ignore: non_constant_identifier_names
  WebDataLogin(this.OnlyLogin,int TotalRowCount, int ExceptionsEnum, String ErrorMessage,
      String UserLogin, String Password, String Neptuncode, int CurrentPage, // ignore: non_constant_identifier_names
      String StudentTrainingID, int LCID, String MobileVersion, // ignore: non_constant_identifier_names
      String MobileServiceVersion) : super(TotalRowCount, ExceptionsEnum, ErrorMessage, UserLogin, // ignore: non_constant_identifier_names
      Password, Neptuncode, CurrentPage, StudentTrainingID, LCID, MobileVersion, MobileServiceVersion);

  WebDataLogin.simplified(String User, String Password, this.OnlyLogin) : super.simplified(User,Password,null,null); // ignore: non_constant_identifier_names
  WebDataLogin.simplifiedOnly(String User, String Password) : this.simplified(User,Password,false); // ignore: non_constant_identifier_names
  WebDataLogin.loginSimplified(StudentData data, this.OnlyLogin) : super.loginSimplified(data);
  WebDataLogin.loginOnlySimplified(StudentData data): this.loginSimplified(data, false);
  WebDataLogin.studentOnlySimplified(StudentData data): this.studentSimplified(data, false);
  WebDataLogin.studentSimplified(StudentData data, this.OnlyLogin) : super.studentSimplified(data);
  WebDataLogin.fromJson(Map<String, dynamic> json) : OnlyLogin = json['OnlyLogin'], super.fromJson(remove<String, dynamic>(json, 'OnlyLogin'));

  @override
  Map<String, dynamic> toJsonMap()
  {

    var map = <String,dynamic>{
      'OnlyLogin':OnlyLogin
    };

    map.addAll(super.toJsonMap());

    return map;

  }

}