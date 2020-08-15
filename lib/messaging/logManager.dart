import 'package:logger/logger.dart';

abstract class LogManager
{

  static final logger = _initLogger();

  static Logger _initLogger()
  {

    var filter = ProductionFilter();
    LogPrinter printer = PrefixPrinter(SimplePrinter(printTime: true));

    assert(((){
      printer = PrettyPrinter(printTime: true);
      return true;
    })());


    return Logger(filter: filter, printer: printer);
  }
}