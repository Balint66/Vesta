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
  factory() => null;

  static dynamic _directory;

  static Future<String> _readAsString(String fileName) async 
  {
    if(PlatformHelper.isWeb())
    {

      var key = fileName.substring(0,fileName.length - 5);

      if(window.localStorage.containsKey(key))
      {

        return window.localStorage[key];

      }
      else
      {

        return "{}";

      }

    }
    else
    {

      if(_directory == null)
      {
        Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
        return "{}";
      }

      io.File file = io.File(_directory.path + fileName);

      if(await file.exists())
        return file.readAsString();
      else
        return "{}";

    }
  }

  static Future<void> _writeAsString(String string, String fileName) async
  {

    if(PlatformHelper.isWeb())
    {
      var key = fileName.substring(0,fileName.length - 5);

      if(window.localStorage.containsKey(key))
      {

        window.localStorage[key] = string;

      }
      else
      {

        window.localStorage.putIfAbsent(key, () => string);

      }
    }
    else
    {

      if(_directory == null)
      {
        Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
        return;
      }

      io.File file = io.File(_directory.path + fileName);

      if(!(await file.exists()))
      {
        file = await file.create();
      }

      file.writeAsString(string);

    }

  }

  static Future<void> saveData() async
  {

    await init();
    
    Map<String, dynamic> map = <String, dynamic>
    {
      "studentData": StudentData.toJsonMap(StudentData.Instance),
      "school": Data.school.asJson()
    };

    await _writeAsString(json.encode(map), "login_data.json");

  }

  static Future<bool> readData() async
  {
    String str = await loadLoginFile();
    Map<String, dynamic> map = json.decode(str);

    if(!(map.containsKey("studentData")&&map.containsKey("school")))
      return false;

    StudentData std = StudentData.fromJsondata(map["studentData"]);

    StudentData.setInstance(std.username, std.password, std.training);

    Map<String, dynamic> data = <String, dynamic>
    {
      "username":StudentData.Instance.username,
      "password":StudentData.Instance.password,
      "school":map["school"]
    };
    return Data.fromJson(json.encode(data));
  }

  static Future<void> clearFileData() async
  {
    await init();

    await _writeAsString("{}", "login_data.json");

  }

  static Future<void> clearAllFileData() async
  {
    await clearFileData();

    await _writeAsString("{}", "login_data.json");

  }

  static Future<String> loadLoginFile() async
  {
    await init();
    
    return await _readAsString("settings.json");

  }

  static Future<void> saveSettings(SettingsData data) async
  {

    await init();

    await _writeAsString(data.toJsonString(), "settings.json");

  }

  static Future<SettingsData> loadSettings() async
  {
    await init();


    String str = await _readAsString("settings.json");

    if(str == "{}")
      return new SettingsData();

    return SettingsData.fromJsonString(str);

  }

  static Future<void> init() async
  {
    if(_directory == null)
    try
    {
      if(!PlatformHelper.isWeb())
        _directory = await getApplicationDocumentsDirectory();
    }
    catch(e)
    {
      Vesta.logger.w("Error happened on platform: ${io.Platform.operatingSystem}\n error was $e");
      //throw e;
    }


  }

}