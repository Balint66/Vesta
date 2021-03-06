import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/loginpage/loginForm.dart';

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

  @override
  void initState() {
    super.initState();
    clearData();
  }

  void clearData()
  {
    if (((Data.password?.isNotEmpty ?? false) || (Data.username?.isNotEmpty ?? false)) ||
          Data.school != null) {
      Data.password = '';
      Data.username = '';
      Data.school = null;
    }

  }

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
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(0,0,0,0),
        elevation: 0, actions: [TextButton.icon(icon: Icon(Icons.settings), 
        onPressed: ()=>Navigator.of(context).pushNamed('/settings/main'), label:Container())],), //Custom top for settings buton
    );

  }
}