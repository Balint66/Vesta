import 'package:flutter/widgets.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/fetchManager.dart';

abstract class BgFetchSateFullWidget extends StatefulWidget
{

  BgFetchSateFullWidget({Key key}) : super(key:key);

  @override
  BgFetchState createState();

}

abstract class BgFetchState<T extends BgFetchSateFullWidget> extends State<T>
    with BackgroundFetchingServiceMixin
{

  @mustCallSuper
  @override
  void initState()
  {
    super.initState();
    print("Registering ${this.runtimeType} to fetching manager.");
    FetchManager.register(this);
  }

}
