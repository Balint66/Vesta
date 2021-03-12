import 'dart:convert';
import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/web/webdata/iWebData.dart';

class WebDataBase extends IWebData
{
  // ignore: non_constant_identifier_names
  final int TotalRowCount;
  // ignore: non_constant_identifier_names
  final int ExceptionsEnum;
  // ignore: non_constant_identifier_names
  final String? ErrorMessage;
  // ignore: non_constant_identifier_names
  final String UserLogin;
  // ignore: non_constant_identifier_names
  final String Password;
  // ignore: non_constant_identifier_names
  final String? Neptuncode;
  // ignore: non_constant_identifier_names
  final int CurrentPage;
  // ignore: non_constant_identifier_names
  final String? StudentTrainingID;
  // ignore: non_constant_identifier_names
  final int LCID;

  WebDataBase(this.UserLogin, this.Password, this.Neptuncode,
      this.StudentTrainingID,
      {this.TotalRowCount = -1, this.ExceptionsEnum = 0, this.ErrorMessage,
      this.CurrentPage = 0, int? LCID}) : LCID = (LCID ?? 1038) ;

  // ignore: non_constant_identifier_names
  WebDataBase.simplified(String User, String Password, String? NeptunCode, String? TrainingData, {int currentPage = 0, int? LCID})
      : this(User, Password, NeptunCode, TrainingData, CurrentPage: currentPage, LCID: LCID);

  WebDataBase.studentSimplified(AccountData data, {int currentPage = 0, int LCID = 1038}) : this.simplified(data.username,
      data.password, data.username, data.training.id.toString(), currentPage: currentPage, LCID: LCID);

  WebDataBase.loginSimplified(AccountData data, {int currentPage = 0, int LCID = 1038}) 
  : this.simplified(data.username, data.password, null, null, currentPage: currentPage, LCID: LCID);

  @override
  Map<String, dynamic> toJsonMap()
  {
    return  <String,dynamic>
    {
      'TotalRowCount': TotalRowCount,
      'ExceptionsEnum' : ExceptionsEnum,
      'ErrorMessage' : ErrorMessage,
      'UserLogin' : UserLogin,
      'Password' : Password,
      'Neptuncode' : Neptuncode,
      'CurrentPage' : CurrentPage,
      'StudentTrainingID' : StudentTrainingID,
      'LCID' : LCID,
      'MobileVersion' : '1.5.2',
      'MobileServiceVersion' : '0'
    };
  }

  static WebDataBase fromJsonString(String string)
  {
    return WebDataBase.fromJson(json.decode(string));
  }

  WebDataBase.fromJson(Map<String, dynamic> json)
  : this(json['UserLogin'], json['Password'], json['Neptuncode'],
        json['StudentTrainingID'].toString(), LCID: json['LCID'],
        CurrentPage: json['CurrentPage'], TotalRowCount: json['TotalRowCount'],
        ExceptionsEnum: json['ExceptionsEnum'], ErrorMessage: json['ErrorMessage'],);

}