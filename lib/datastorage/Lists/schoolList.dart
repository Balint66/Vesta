import 'dart:convert';

class SchoolList
{
  List<School> schools;

  SchoolList._(this.schools);

  factory SchoolList.fromJson(String json)
  {

    var list = <School>[];
    var inJSON = jsonDecode(json).cast<Map<String, dynamic>>();

    if(inJSON != null)
    {

      for(var item in inJSON)
      {

        list.add(School.fromJson(jsonEncode(item)));

      }
    }

    var schl = SchoolList._(list);

    return schl;

  }

  static String toJson(SchoolList list)
  {
      var res = '';
      for(var item in list.schools)
      {

        res = '$res${School.toJson(item)},';

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
  final String? Url;

  School(this.Languages, this.Name, this.NeptunMobileServiceVersion, this.OMCode, this.Url);

  static School fromJson(String json)
  {

    var inJSON = jsonDecode(json);
    return School(inJSON['Languages'],inJSON['Name'],"${inJSON["NeptunMobileServiceVersion"]}",inJSON['OMCode'],inJSON['Url']);

  }

  static String toJson(School sch)
  {

    var map = <String,dynamic>
    {
      'Languages':sch.Languages,
      'Name':sch.Name,
      'NeptunMobileServiceVersion':sch.NeptunMobileServiceVersion,
      'OMCode':sch.OMCode,
      'Url':sch.Url
    };

    return json.encode(map);
  }

  String asJson()
  {
    return School.toJson(this);
  }

}