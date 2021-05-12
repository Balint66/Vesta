import 'dart:convert';

import 'package:vesta/datastorage/Lists/schoolList.dart';
import 'package:vesta/datastorage/acountData.dart';

abstract class AccountManager
{

  static final List<AccountData> _accounts = [];
  static List<AccountData> get accounts => List.of(_accounts, growable: false);
  static int get acountsCount => _accounts.length;
  
  static AccountData get currentAccount => _accounts.isNotEmpty ? _accounts[_index] : throw 'There is no account in the list';
  static int _index = 0;

  static void loadFromJson(String str, School school) =>
    loadFromJsondata(json.decode(str), school);
  

  static void loadFromJsondata(Map<String,dynamic> json, School school) =>
    addNeptunUser(json['UserLogin'] ,json['Password'], school, TrainingData.listFromJson(json['TrainingList']));

  static void loadFromFullJson(List<Map<String,dynamic>> json) 
  {
    for(var accj in json)
    {
      var acc = AccountData(accj['username'], accj['password'],
      TrainingData.fromJson(accj['training']), School.fromJson(accj['school']));
      if(!_accounts.contains(acc)){
        _accounts.add(acc);
      }
    }
  }

  static void addNeptunUser(String username, String password, School school, List<TrainingData> trainings)
  {
    for(var training in trainings)
    {
      var acc = AccountData(username, password,
        training, school);
      if(!_accounts.contains(acc)){
        _accounts.add(acc);
      }
    }
  }

  static void removeCurrentAcount()
  {
    _accounts.removeAt(_index);
    _index--;
    if(_index < 0)
    {
      _index = _accounts.isEmpty ? 0 : _accounts.length - 1;
    }
  }

  static void removeAcountWithIndex(int i)
  {
    _accounts.removeAt(i);
    if(_index >= _accounts.length)
    {
      _index = _accounts.isEmpty ? 0 : _accounts.length - 1;
    }
  }

  static void setAscurrent(AccountData data)
  {
    if(!_accounts.contains(data))
    {
      _accounts.add(data);
    }

    _index = _accounts.indexOf(data);

  }

  static List<Map<String, dynamic>> toJsonList()
  {
    return List.of(_accounts).map((e) => <String, dynamic>{
      'username': e.username,
      'password':e.password,
      'training': TrainingData.toJsonMap(e.training),
      'school': e.school.asJson()
    }).toList();
  }

}