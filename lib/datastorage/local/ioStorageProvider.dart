import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:vesta/Vesta.dart';

Directory? _directory;

Future<void> init() async
{
  if(_directory == null) {
    try
    {
      
      _directory = await getApplicationDocumentsDirectory();
      
    }
    catch(e)
    {
      Vesta.logger.w('Error happened on platform: ${Platform.operatingSystem}\n error was $e');
      //throw e;
    }
  }
}

Future<String> readAsString(String fileName) async
{
  if(_directory == null)
  {
    Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
    return '{}';
  }

  var file = File('${_directory!.path}${Platform.pathSeparator}$fileName');

  if(await file.exists()) {
    return file.readAsString();
  } else {
    return '{}';
  }
}

Future<void> writeAsString(String string, String fileName) async
{
  if(_directory == null)
  {
    Vesta.logger.i("Init wasn't successful. Maybe we are on an unsupported platform? (directory was null)");
    return;
  }

  
  var file = File('${_directory!.path}${Platform.pathSeparator}$fileName');

  if(!(await file.exists()))
  {
    file = await file.create();
  }

  await file.writeAsString(string);
}