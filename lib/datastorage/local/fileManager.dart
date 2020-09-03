import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:vesta/Vesta.dart';
import 'package:universal_io/io.dart' as io;
import 'package:universal_html/html.dart';

import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/settings/settingsData.dart';
import 'package:vesta/utils/PlatformHelper.dart';

class FileManager
{
  factory FileManager() => null;

  static dynamic _directory;

  static Future<String> _readAsString(String fileName) async 
  {
    if(PlatformHelper.isWeb())
    {

      var key = fileName.split('.')[0];

      if(window.localStorage.containsKey(key))
      {

        return window.localStorage[key];

      }
      else
      {

        return '{}';

      }

    }
    else
    {

      if(_directory == null)
      {
        Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
        return '{}';
      }

      var file = io.File(_directory.path + fileName);

      if(await file.exists()) {
        return file.readAsString();
      } else {
        return '{}';
      }

    }
  }

  static Future<void> _writeAsString(String string, String fileName) async
  {

    if(PlatformHelper.isWeb())
    {
      var key = fileName.split('.')[0];

      window.localStorage[key] = string;
    }
    else
    {

      if(_directory == null)
      {
        Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
        return;
      }

      
      var file = io.File('${_directory.path}${io.Platform.pathSeparator}$fileName');

      if(!(await file.exists()))
      {
        file = await file.create();
      }

      await file.writeAsString(string);

    }

  }

  static Future<void> saveData() async
  {

    await init();
    
    var map = <String, dynamic>
    {
      'studentData': StudentData.toJsonMap(StudentData.Instance),
      'school': Data.school.asJson()
    };

    await _writeAsString(json.encode(map), 'login_data.json');

  }

  static Future<bool> readData() async
  {
    var str = await loadLoginFile();
    Map<String, dynamic> map = json.decode(str);

    if(!(map.containsKey('studentData')&&map.containsKey('school'))) {
      return false;
    }

    var std = StudentData.fromJsondata(map['studentData']);

    StudentData.setInstance(std.username, std.password, std.training);

    var data = <String, dynamic>
    {
      'username':StudentData.Instance.username,
      'password':StudentData.Instance.password,
      'school':map['school']
    };
    return Data.fromJson(json.encode(data));
  }

  static Future<void> clearFileData() async
  {
    await init();

    await _writeAsString('{}', 'login_data.json');

  }

  static Future<void> clearAllFileData() async
  {
    await clearFileData();

    await _writeAsString('{}', 'settings.json');

  }

  static Future<String> loadLoginFile() async
  {
    await init();
    
    return await _readAsString('login_data.json');

  }

  static Future<void> saveSettings(SettingsData data) async
  {

    await init();

    await _writeAsString(data.toJsonString(), 'settings.json');

  }

  static Future<SettingsData> loadSettings() async
  {
    await init();


    var str = await _readAsString('settings.json');

    if(str == '{}') {
      return SettingsData();
    }

    return SettingsData.fromJsonString(str);

  }

  static Future<void> writeLog(List<String> log) async
  {
    await _writeAsString(log.join('\n'), 'log.txt');
  }

  static Future<List<String>> readLog() async
  {
    return (await _readAsString('log.txt')).split('\n');
  }

  static Future<void> init() async
  {
    if(_directory == null) {
      try
      {
        if(!PlatformHelper.isWeb()) {
          _directory = await getApplicationDocumentsDirectory();
        }
      }
      catch(e)
      {
        Vesta.logger.w('Error happened on platform: ${io.Platform.operatingSystem}\n error was $e');
        //throw e;
      }
    }


  }

}