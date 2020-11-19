import 'package:universal_io/io.dart';

bool isWeb() => Platform.operatingSystem == '' || Platform.operatingSystem == 'Web' || Platform.operatingSystem == 'web';