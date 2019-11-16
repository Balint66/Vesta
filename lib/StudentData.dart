import 'dart:convert';

class StudentData
{

  final String username;
  final String password;
  String _neptunCode;
  final List<TrainingData> training = new List();

  StudentData(this.username,this.password);

  static StudentData fromJson(String str)
  {
     return StudentData.fromJsondata(json.decode(str));
  }

  static StudentData fromJsondata(Map<String,dynamic> json)
  {
    return null;
  }


}
class TrainingData
{

  final String name;
  final String id;

  TrainingData(this.name, this.id);

}