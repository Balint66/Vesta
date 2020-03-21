import 'package:flutter/widgets.dart';

abstract class BgFetchSateFullWidget extends StatefulWidget
{

  BgFetchSateFullWidget({Key key}) : super(key:key);

  @override
  BgFetchState createState();

}

abstract class BgFetchState<T extends BgFetchSateFullWidget> extends State<T>
{

}
