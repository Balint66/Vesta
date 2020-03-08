import 'dart:convert';

import 'package:vesta/datastorage/school/schoolList.dart';

class Data
{

  static String username;
  static String password;
  static School school;

  factory()=> null;

  _(){}

  static String toJsonString()
  {
    if(username == null || password == null || school == null)
    {
      return "{}";
    }

    Map map = {"username":username,"password":password,"school":school.asJson()};

    return json.encode(map);

  }

  static bool fromJson(String jsonString)
  {
    Map<String, String> map = json.decode(jsonString);

    if(map.keys.isEmpty || !map.containsKey("username") || !map.containsKey("password")
        || !map.containsKey("school"))
      return false;

    username = map["username"];
    password = map["password"];
    school = School.fromJson(map["school"].toString());

    return true;

  }

}