import 'package:flutter/material.dart';
import 'package:vesta/loginpage/loginForm.dart';
import 'package:vesta/routing/router.dart';

class Authorization extends StatefulWidget
{

  const  Authorization({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState()
  {
    return AuthorizationState();
  }

}

class AuthorizationState extends State<Authorization>
{

  bool implyLeading = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body:Center(
            child: SingleChildScrollView(
          child: LoginForm(),
          ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: implyLeading,
        backgroundColor: Color.fromARGB(0,0,0,0),
        elevation: 0, 
        actions: [TextButton.icon(icon: Icon(Icons.settings), 
        onPressed: ()=>setState((){
          implyLeading = false;
          (Router.of(context).routerDelegate as MainDelegate).SetPath('/settings');
        }),
        label:Container())],), //Custom top for settings buton
    );

  }
}