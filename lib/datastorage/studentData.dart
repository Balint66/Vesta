import 'dart:convert';

const de_LCID = 1031;
const en_us_LCID = 1033; //uk in the future?
const hun_LCID = 1038;

class StudentData
{

  // ignore: non_constant_identifier_names
  static StudentData? get Instance => _instance;
  static StudentData? _instance;

  final String? username;
  final String? password;
  final List<TrainingData> training = [];
  int LCID = hun_LCID;
  int _currentTrainingNumero = 0;
  TrainingData? get currentTraining => _currentTrainingNumero >= 0
      && _currentTrainingNumero < training.length
      ? training[_currentTrainingNumero] : null;

  StudentData._(this.username,this.password, List<TrainingData>? data, {this.LCID = hun_LCID})
  {
    if(data != null) {
      training.addAll(data);
    }

  }

  TrainingData? nextTraining()
  {
    _currentTrainingNumero++;
    if(_currentTrainingNumero>= training.length) {
      _currentTrainingNumero = 0;
    }
    return currentTraining;
  }

  TrainingData? prevTraining()
  {
    _currentTrainingNumero--;
    if(_currentTrainingNumero < 0) {
      _currentTrainingNumero = training.isNotEmpty ? training.length - 1 : 0;
    }
    return currentTraining;
  }

  factory StudentData.fromJson(String str)
  {
    return StudentData.fromJsondata(json.decode(str));
  }

  factory StudentData.fromJsondata(Map<String,dynamic> json)
  {
    return StudentData._(json['NeptunCode'].toString(), json['Password'].toString(),
        TrainingData.listFromJson(json['TrainingList']), LCID: json['LCID'] as int);
  }

  static void setInstance(String username, String password, List<TrainingData>? data, {int? LCID})
  {
    _instance = StudentData._(username, password, data, LCID: LCID ?? hun_LCID);
  }

  static Map<String,dynamic> toJsonMap(StudentData data)
  {
    return <String,dynamic>{
      'NeptunCode': data.username,
      'Password': data.password,
      'LCID': data.LCID,
      'TrainingList': TrainingData.toJsonMapList(data.training)
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
    return TrainingData(jsonObj['Description'], jsonObj['Id'], jsonObj['Code']);
  }

  static List<TrainingData>? listFromJsonString(String str)
  {

    return TrainingData.listFromJson(List<Map<String,dynamic>>
        .from(json.decode(str)));
  }

  static List<TrainingData>? listFromJson(List<dynamic>? data)
  {

    if(data == null) {
      return null;
    }

    var newData = List<Map<String, dynamic>>.from(data);

    var result = <TrainingData>[];
    
    for(var item in newData)
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
    return <String, dynamic>{'Code':training.code,'Id':training.id, 'Description':training.description};
  }

  static String toJson(TrainingData training)
  {
    return json.encode(toJsonMap(training));
  }

}