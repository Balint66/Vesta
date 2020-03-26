import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vesta/datastorage/studentData.dart';

Map<T,V> remove<T,V>(Map<T,V> orig, Object key)
{

orig.remove(key);

return orig;

}

class WebDataBase
{
  // ignore: non_constant_identifier_names
  final int TotalRowCount;
  // ignore: non_constant_identifier_names
  final int ExceptionsEnum;
  // ignore: non_constant_identifier_names
  final String ErrorMessage;
  // ignore: non_constant_identifier_names
  final String UserLogin;
  // ignore: non_constant_identifier_names
  final String Password;
  // ignore: non_constant_identifier_names
  final String Neptuncode;
  // ignore: non_constant_identifier_names
  final int CurrentPage;
  // ignore: non_constant_identifier_names
  final String StudentTrainingID;
  // ignore: non_constant_identifier_names
  final int LCID;
  // ignore: non_constant_identifier_names
  final double MobileVersion;
  // ignore: non_constant_identifier_names
  final double MobileServiceVersion;

  StudentData get studentdata =>  StudentData.fromJson(json.encode(this));

  WebDataBase(this.TotalRowCount, this.ExceptionsEnum, this.ErrorMessage,
      this.UserLogin, this.Password, this.Neptuncode, this.CurrentPage,
      this.StudentTrainingID, this.LCID, this.MobileVersion,
      this.MobileServiceVersion);

  // ignore: non_constant_identifier_names
  WebDataBase.simplified(String User, String Password, String NeptunCode, String TrainingData, {int currentPage = 0})
      : this(-1, 0, null, User, Password, NeptunCode, currentPage, TrainingData, 1038, 1.5,0);

  WebDataBase.studentSimplified(StudentData data) : this.simplified(data.username,
      data.password, data.username, data.currentTraining?.id.toString());

  WebDataBase.loginSimplified(StudentData data) : this.simplified(data.username, data.password, null, null);

  String toJson()
  {
    return json.encode(this.toJsonMap());
  }

  @mustCallSuper
  Map<String, dynamic> toJsonMap()
  {
    return  <String,dynamic>
    {
      "TotalRowCount": TotalRowCount,
      "ExceptionsEnum" : ExceptionsEnum,
      "ErrorMessage" : ErrorMessage,
      "UserLogin" : UserLogin,
      "Password" : Password,
      "Neptuncode" : Neptuncode,
      "CurrentPage" : CurrentPage,
      "StudentTrainingID" : StudentTrainingID,
      "LCID" : LCID,
      "MobileVersion" : MobileVersion,
      "MobileServiceVersion" : MobileServiceVersion
    };
  }

  static WebDataBase fromJsonString(String string)
  {
    return new WebDataBase.fromJson(json.decode(string));
  }

  WebDataBase.fromJson(Map<String, dynamic> json)
  : this(json["TotalRowCount"], json["ExceptionsEnum"], json["ErrorMessage"],
        json["UserLogin"], json["Password"], json["Neptuncode"], json["CurrentPage"],
        json["StudentTrainingID"].toString(), json["LCID"], double.parse(json["MobileVersion"]), (json["MobileServiceVersion"] as int).toDouble());

}