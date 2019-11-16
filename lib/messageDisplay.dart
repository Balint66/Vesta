import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Data.dart';
import 'package:vesta/StudentData.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/backgroundFetchingServiceMixin.dart';
import 'package:vesta/webServices.dart';

class MessageDisplay extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return MessageDisplayState();
  }

}

class MessageDisplayState extends State<MessageDisplay> with BackgroundFetchingServiceMixin
{

  Future _post;

  @override
  void initState() {
    super.initState();
    _post = WebServices.getMessages(Data.school, StudentData.Instance);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:_post,
        builder: (context,snapshot){
      if(snapshot.hasData){
       return Text("${snapshot.data}");
      }
      if(snapshot.hasError){
        Vesta.showSnackbar(Text("${snapshot.error}"));
      }
      return CircularProgressIndicator();
    });
  }

}