import 'dart:convert';

import 'package:vesta/datastorage/Lists/schoolList.dart';

abstract class Data
{

  static String? username;
  static String? password;
  static School? school;

  static String toJsonString()
  {
    if(username == null || password == null || school == null)
    {
      return '{}';
    }

    var map = <String, dynamic>{'username':username,'password':password,'school':school?.asJson()};

    return json.encode(map);

  }

  static bool fromJson(String jsonString)
  {
    Map<String, dynamic> map = json.decode(jsonString);

    if(map.keys.isEmpty || !map.containsKey('username') || !map.containsKey('password')
        || !map.containsKey('school')) {
      return false;
    }

    username = map['username'].toString();
    password = map['password'].toString();
    school = School.fromJson(map['school'].toString());

    return true;

  }

}