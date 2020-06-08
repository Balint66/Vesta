import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:vesta/Vesta.dart';
import 'dart:io';

import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/settings/settingsData.dart';

class FileManager
{
  factory() => null;

  static Directory directory;

  static Future<void> saveData() async
  {

    await init();
    if(directory == null)
    {
      Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
      return;
    }

    File file = File(directory.path + "login_data.json");

    if(!(await file.exists()))
    {
      file = await file.create();
    }
    
    Map<String, dynamic> map = <String, dynamic>
    {
      "studentData": StudentData.toJsonMap(StudentData.Instance),
      "school": Data.school.asJson()
    };
    
    file.writeAsString(json.encode(map));

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
    if(directory == null)
    {
      Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
      return;
    }

    File file = File(directory.path + "login_data.json");

    await file.writeAsString("{}");

  }

  static Future<String> loadLoginFile() async
  {
    await init();
    if(directory == null)
    {
      Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
      return "{}";
    }
    File file = File(directory.path + "login_data.json");

    if(await file.exists())
      return file.readAsString();
    else
      return "{}";

  }

  static Future<void> saveSettings(SettingsData data) async
  {

    await init();
    if(directory == null)
    {
      Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
      return;
    }
    File file = File(directory.path+"settings.json");

    file.writeAsString(data.toJsonString());

  }

  static Future<SettingsData> loadSettings() async
  {
    await init();

    if(directory == null)
    {
      Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
      return null;
    }

    File file = File(directory.path +"settings.json");

    if(! (await file.exists()))
      return new SettingsData();

    return SettingsData.fromJsonString(await file.readAsString());

  }

  static Future<void> init() async
  {
    if(directory == null)
    try
    {
      directory = await getApplicationDocumentsDirectory();
    }
    catch(e)
    {
      Vesta.logger.w("Error happened on platform: ${Platform.operatingSystem}\n error was $e");
      //throw e;
    }


  }

}