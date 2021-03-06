import 'dart:convert';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/settings/settingsData.dart';

import './noneStorageProvider.dart' 
  if (dart.library.io) './ioStorageProvider.dart'
  if (dart.library.html) './browserStorageProvider.dart'
  as storage_provider;

abstract class FileManager
{


  static Future<String> readAsString(String fileName) async => await storage_provider.readAsString(fileName);

  static Future<void> writeAsString(String string, String fileName) async => await storage_provider.writeAsString(string, fileName);

  static Future<void> saveData() async
  {

    await init();
    
    var map = AccountManager.toJsonList();

    await writeAsString(json.encode(map), 'login_data.json');

  }

  static Future<bool> readData() async
  {
    
    var str = await loadLoginFile();
    var map = json.decode(str);

    if(map is Map)
    {

      if(!(map.containsKey('studentData') && map.containsKey('school'))) {
        return false;
      }

      var std = AccountData.fromJsondata(map as Map<String, dynamic>);

      AccountManager.setAscurrent(std);

      var data = <String, dynamic>
      {
        'username':std.username,
        'password':std.password,
        'school':map['school']
      };
      return Data.fromJson(json.encode(data));
    }
    else if( map is List)
    {
      AccountManager.loadFromFullJson(map.cast());
      return true;
    }
    else
    {
      return false;
    }
  }

  static Future<void> clearLoginFileData() async
  {
    await init();

    await writeAsString('{}', 'login_data.json');

  }

  static Future<void> clearAllFileData() async
  {
    await clearLoginFileData();

    await writeAsString('{}', 'settings.json');

  }

  static Future<String> loadLoginFile() async
  {
    await init();
    
    return await readAsString('login_data.json');

  }

  static Future<void> saveSettings(SettingsData data) async
  {

    await init();

    await writeAsString(data.toJsonString(), 'settings.json');

  }

  static Future<SettingsData?> loadSettings() async
  {
    await init();


    var str = await readAsString('settings.json');

    if(str == '{}') {
      return SettingsData();
    }

    return SettingsData.fromJsonString(str);

  }

  static Future<void> writeLog(List<String> log) async
  {
    await writeAsString(log.join('\n'), 'log.txt');
  }

  static Future<List<String>> readLog() async
  {
    return (await readAsString('log.txt')).split('\n');
  }

  static Future<void> init() async => storage_provider.init();

}