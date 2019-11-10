
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/Data.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/webServices.dart';

class LoginButton extends StatefulWidget
{

  final LoginBtnState state = new LoginBtnState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

}

class LoginBtnState extends State<LoginButton>
{

  static final StreamController controller = new StreamController<Widget>();
  static MaterialButton get btn =>  MaterialButton(
    onPressed:  /*btnfnc()*/ (){controller.sink.add(login);},
    child: Text("Login",maxLines: 1,),
    color: Colors.red,
    minWidth: 150.0 ,
  );

  static FutureBuilder get login => new FutureBuilder<bool>(future: WebServices.login(Data.username, Data.password, Data.school),
      builder: (context,snapshot)
      {
        if(snapshot.hasData){
          controller.sink.add(btn);
          if(snapshot.data)
            mainController.sink .add(mainProg);
          return btn;
        }

        if(snapshot.hasError){

          Vesta.showSnackbar(new Text("${snapshot.error}"));
          controller.sink.add(btn);
          return btn;
        }

        return CircularProgressIndicator();

      });

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(initialData: btn,stream: controller.stream,builder: (context,snapshot)
    {
      if(snapshot.hasData)
        return snapshot.data;
      return btn;
    },);
  }

  static Function btnfnc()
  {
    if(Data.school == null|| Data.password == null || Data.password.isEmpty|| Data.username == null || Data.username.isEmpty)
      return null;
    else
    {
         return (){controller.sink.add(login);};
    }
  }


}