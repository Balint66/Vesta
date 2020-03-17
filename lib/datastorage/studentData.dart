import 'dart:convert';

class StudentData
{

  // ignore: non_constant_identifier_names
  static StudentData get Instance => _instance;
  static StudentData _instance;

  final String username;
  final String password;
  String _neptunCode; // ignore: unused_field
  final List<TrainingData> training = new List();
  int _currentTrainingNumero = 0;
  TrainingData get currentTraining => _currentTrainingNumero >= 0
      && _currentTrainingNumero < training.length
      ? training[_currentTrainingNumero] : null;

  StudentData._(this.username,this.password, List<TrainingData> data)
  {
    if(data != null)
      training.addAll(data);
    _neptunCode = username;
  }

  TrainingData nextTraining()
  {
    _currentTrainingNumero++;
    if(_currentTrainingNumero>= training.length)
      _currentTrainingNumero = 0;
    return currentTraining;
  }

  TrainingData prevTraining()
  {
    _currentTrainingNumero--;
    if(_currentTrainingNumero < 0)
      _currentTrainingNumero = training.length != 0 ? training.length - 1 : 0;
    return currentTraining;
  }

  static StudentData fromJson(String str)
  {
     return StudentData.fromJsondata(json.decode(str));
  }

  static StudentData fromJsondata(Map<String,dynamic> json)
  {
    return new StudentData._(json["NeptunCode"] as String, json["Password"] as String,
        TrainingData.listFromJson(json["TrainingList"]));
  }

  static setInstance(String username, String password, List<TrainingData> data)
  {
    _instance = new StudentData._(username, password, data);
  }

  static Map<String,dynamic> toJsonMap(StudentData data)
  {
    return <String,dynamic>{
      "NeptunCode": data.username,
      "Password": data.password,
      "TrainingList": TrainingData.toJsonMapList(data.training)
    };
  }

  static String toJson(StudentData data)
  {
    return json.encode(toJsonMap(data));
  }


}
class TrainingData
{

  final String description;
  final int id;
  final String code;

  TrainingData(this.description, this.id, this.code);

  static TrainingData fromJsonString(String str)
  {
    return TrainingData.fromJson(json.decode(str));
  }

  static TrainingData fromJson(Map<String, dynamic> jsonObj)
  {
    return new TrainingData(jsonObj["Description"], jsonObj["Id"], jsonObj["Code"]);
  }

  static List<TrainingData> listFromJsonString(String str)
  {

    return TrainingData.listFromJson(List<Map<String,dynamic>>
        .from(json.decode(str)));
  }

  static List<TrainingData> listFromJson(List<dynamic> data)
  {

    if(data == null)
      return null;

    List<Map<String, dynamic>> newData = List.from(data);

    List<TrainingData> result = new List();
    
    for(Map<String,dynamic> item in newData)
    {
      result.add(TrainingData.fromJson(item));
    }
    
    return result;

  }

  static List<Map<String, dynamic>> toJsonMapList(List<TrainingData> trainings)
  {
    return List.generate(trainings.length, (index) => TrainingData.toJsonMap(trainings[index]));
  }

  static String toJsonList(List<TrainingData> list)
  {
    return json.encode(toJsonMapList(list));
  }

  static Map<String, dynamic> toJsonMap(TrainingData training)
  {
    return <String, dynamic>{"Code":training.code,"Id":training.id, "Description":training.description};
  }

  static String toJson(TrainingData training)
  {
    return json.encode(toJsonMap(training));
  }

}