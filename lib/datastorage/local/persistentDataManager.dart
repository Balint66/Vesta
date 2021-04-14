import 'dart:convert';
import 'dart:math';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/settings/settingsData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vesta/utils/encrypt_codec.dart';


import './noneStorageProvider.dart' 
  if (dart.library.io) './ioStorageProvider.dart'
  if (dart.library.html) './browserStorageProvider.dart'
  as storage_provider;

abstract class FileManager
{

  static late final Codec<Map<String, dynamic>, String> codec;

  static Future<String> readAsString(String fileName) async => await storage_provider.readAsString(fileName);

  static Future<void> writeAsString(String string, String fileName) async => await storage_provider.writeAsString(string, fileName);

  static Future<void> saveData() async
  {
    
    var map = AccountManager.toJsonList();

    await writeAsString(codec.encode(map.asMap().map((e, map)=> MapEntry('$e',map[e]))), 'login_data.json');

  }

  static Future<bool> readData() async
  {
    
    var map = await loadLoginFile();

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

    await writeAsString('{}', 'login_data.json');

  }

  static Future<void> clearAllFileData() async
  {
    await clearLoginFileData();

    await writeAsString('{}', 'settings.json');

  }

  static Future<dynamic> loadLoginFile() async
  {
    
    var str = await readAsString('login_data.json');
    late dynamic map;
    try{
      map = json.decode(str);
    }
    catch(e)
    {
      var mp = codec.decode(str);
      var ls = <Map<String, dynamic>>[];
      mp.map((i, ma)=>MapEntry<int, Map<String, dynamic>>(int.parse(i), map[i])).forEach((i, m)=>ls[i]=m);
      map = ls;

    }
    finally
    {
      return map;
    }

  }

  static Future<void> saveSettings(SettingsData data) async
  {

    await writeAsString(data.toJsonString(), 'settings.json');

  }

  static Future<SettingsData?> loadSettings() async
  {

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

  static Future<void> init() async
  {
    var _secureStorage = FlutterSecureStorage();
    var cryptKey = await _secureStorage.read(key: 'crypt_key');
    if(cryptKey == null)
    {
      var rnn = Random.secure().nextInt(4294967296);
      await _secureStorage.write(key: 'crypt_key', value: rnn.toString());
      cryptKey = rnn.toString();
    }

    codec = getCodec(cryptKey);

    await storage_provider.init();
  }

}