import 'dart:convert';

class SchoolList
{
  List<School> schools;

  SchoolList(this.schools);

  static SchoolList fromJson(String json)
  {

    var list = new List<School>();
    var inJSON = jsonDecode(json);

    for(var item in inJSON)
    {

      list.add(School.fromJson(jsonEncode(item)));

    }

    var schl = new SchoolList(list);

    return schl;

  }

  static String toJson(SchoolList list)
  {
      String res = "";
      for(var item in list.schools)
      {

        res = "$res${School.toJson(item)},";

      }

      return res;

  }

  String asJson()
  {
    return SchoolList.toJson(this);
  }

}

class School
{
  // ignore: non_constant_identifier_names
  final String Languages;
  // ignore: non_constant_identifier_names
  final String Name;
  // ignore: non_constant_identifier_names
  final String NeptunMobileServiceVersion;
  // ignore: non_constant_identifier_names
  final String OMCode;
  // ignore: non_constant_identifier_names
  final String Url;

  School(this.Languages, this.Name, this.NeptunMobileServiceVersion, this.OMCode, this.Url);

  static School fromJson(String json)
  {

    var inJSON = jsonDecode(json);
    return new School(inJSON["Languages"],inJSON["Name"],"${inJSON["NeptunMobileServiceVersion"]}",inJSON["OMCode"],inJSON["Url"]);

  }

  static String toJson(School sch)
  {
    return "{\"Languages\":\"${sch.Languages}\",\"Name\":\"${sch.Name}\",\"NeptunMobileServiceVersion\":\"${sch.NeptunMobileServiceVersion}\",\"OMCode\":\"${sch.OMCode}\",\"Url\":\"${sch.Url}\"";
  }

  String asJson()
  {
    return School.toJson(this);
  }

}