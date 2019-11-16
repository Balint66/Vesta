import 'dart:convert';

class StudentData
{

  static StudentData get Instance => _instance;
  static StudentData _instance;

  final String username;
  final String password;
  String _neptunCode;
  final List<TrainingData> training = new List();
  int _curentTrainingNumero = 0;
  TrainingData get currentTraining => training[_curentTrainingNumero];

  StudentData._(this.username,this.password, List<TrainingData> data)
  {
    if(data != null)
      training.addAll(data);
    _neptunCode = username;
  }

  TrainingData nextTraining()
  {
    _curentTrainingNumero++;
    if(_curentTrainingNumero>= training.length)
      _curentTrainingNumero = 0;
    return currentTraining;
  }

  TrainingData prevTraining()
  {
    _curentTrainingNumero--;
    if(_curentTrainingNumero < 0)
      _curentTrainingNumero = training.length - 1;
    return currentTraining;
  }

  static StudentData fromJson(String str)
  {
     return StudentData.fromJsondata(json.decode(str));
  }

  static StudentData fromJsondata(Map<String,dynamic> json)
  {
    return new StudentData._(json["username"] as String, json["password"] as String,
        TrainingData.listFromJson(json["TrainingList"]));
  }

  static setInstance(String username, String password, List<TrainingData> data)
  {
    _instance = new StudentData._(username, password, data);
  }


}
class TrainingData
{

  final String description;
  final String id;
  final String code;

  TrainingData(this.description, this.id, this.code);

  static TrainingData fromJsonString(String str)
  {
    return TrainingData.fromJson(json.decode(str));
  }

  static TrainingData fromJson(Map<String, dynamic> jsonObj)
  {
    return new TrainingData(jsonObj["Description"], jsonObj["ID"], jsonObj["Code"]);
  }

  static List<TrainingData> listFromJsonString(String str)
  {

    List<Map<String,dynamic>> maplist = List<Map<String,dynamic>>.from(json.decode(str));

    return TrainingData.listFromJson(maplist);
  }

  static List<TrainingData> listFromJson(List<Map<String,dynamic>> data)
  {

    List<TrainingData> result = new List();
    
    for(Map<String,dynamic> item in data)
    {
      result.add(TrainingData.fromJson(item));
    }
    
    return result;

  }

}