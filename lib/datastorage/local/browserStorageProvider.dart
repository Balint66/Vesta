import 'package:universal_html/html.dart';

Future<void> init() async{}

Future<String> readAsString(String fileName) async
{
  var key = fileName.split('.')[0];

  if(window.localStorage.containsKey(key))
  {

  return window.localStorage[key] ?? '{}';

  }
  else
  {

  return '{}';

  }

}

Future<void> writeAsString(String string, String fileName) async
{
  var key = fileName.split('.')[0];

  window.localStorage[key] = string;
}