import 'package:logger/logger.dart';
import 'package:vesta/datastorage/local/persistentDataManager.dart';

abstract class LogManager
{

  static final logger = _initLogger();

  static Logger _initLogger()
  {

    var filter = ProductionFilter();
    LogPrinter printer = PrefixPrinter(SimplePrinter(printTime: true));
    LogOutput output = _MyOutput();
    var level = Level.warning;

    assert(((){
      output = ConsoleOutput();
      printer = PrettyPrinter(printTime: true);
      level = Level.verbose;
      return true;
    })());


    return Logger(filter: filter, printer: printer, output: output, level: level);
  }
}

class _MyOutput extends ConsoleOutput
{

  final List<String> lines = <String>[];
  bool lock = false;

  @override
  void init()
  {
    super.init();
    FileManager.readLog().then((value) => lines.addAll(value));
  }

  @override
  void output(OutputEvent event) 
  {
    
    if(lines.length >= 50)
    {
      lines.removeRange(0, event.lines.length);
    }

    lines.addAll(event.lines);

    if(!lock)
    {
      lock = true;
      FileManager.writeLog(lines).then((value) => lock = false);
    }

    super.output(event);
  }

}