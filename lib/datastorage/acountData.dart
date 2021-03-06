import 'dart:convert';
import 'dart:ui';

import 'package:vesta/utils/ColorUtils.dart';

import 'Lists/schoolList.dart';

const de_LCID = 1031;
const en_us_LCID = 1033; //uk in the future?
const hun_LCID = 1038;

class AccountData
{

  final String username;
  final String password;
  final TrainingData training;
  final School school;
  int LCID = hun_LCID;

  Color? _color;
  Color get color => _color ?? (throw 'The color wasn\'t specified!');

  AccountData(this.username,this.password, this.training, this.school, {this.LCID = hun_LCID, Color? color})
    : _color = (color 
      ?? Color(ColorUtils.listToInt(ColorUtils.colorFromTraining(training.code, training.id))))
          .withAlpha(255);

  factory AccountData.fromJsondata(Map<String, dynamic> data)
  {
    if(data.containsKey('studentData'))
    {
      return AccountData(data['studentData']['NeptunCode'],data['studentData']['Password'],
        TrainingData.fromJson(data['studentData']['TrainingList'][0]),School.fromJson(data['school']));
    }
    else
    {
      return AccountData(data['username'],data['password'],data['training'],School.fromJson(data['school']), color: data['Color']);
    }
  }

  factory AccountData.copy(AccountData other) 
    => AccountData(other.username, other.password, other.training, other.school);


  bool operator(Object other) => other is AccountData
    && other.username == username && other.password == password && other.training == training
    && other.school == school;

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
    return TrainingData(jsonObj['Description'], jsonObj['Id'],
     jsonObj['Code']);
  }

  static List<TrainingData> listFromJsonString(String str)
  {

    return TrainingData.listFromJson(List<Map<String,dynamic>>
        .from(json.decode(str)));
  }

  static List<TrainingData> listFromJson(List<dynamic>? data)
  {

    var newData = List<Map<String, dynamic>>.from(data ?? []);

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
    return <String, dynamic>{
      'Code':training.code,
      'Id':training.id,
      'Description':training.description,
    };
  }

  static String toJson(TrainingData training)
  {
    return json.encode(toJsonMap(training));
  }

}