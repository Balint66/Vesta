import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:vesta/datastorage/data.dart';

class FileManager
{
  factory() => null;

  static Directory directory;

  static Future<void> saveData() async
  {

    await init();

    File file = File(directory.path + "login_data.json");

    if(!(await file.exists()))
    {
      file = await file.create();
    }
    
    file.writeAsString(Data.toJsonString());

  }

  static Future<bool> readData() async
  {
    String str = await loadFile();
    return Data.fromJson(str);
  }

  static Future<String> loadFile() async
  {
    await init();
    File file = File(directory.path + "login_data.json");

    return file.readAsString();

  }

  static Future<void> init() async
  {
    if(directory == null)
      directory = await getApplicationDocumentsDirectory();
  }

}