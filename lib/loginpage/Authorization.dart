import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/loginpage/loginForm.dart';
import 'package:vesta/datastorage/studentData.dart';

class Authorization extends StatefulWidget
{

  const  Authorization({Key key}) : super(key: key);


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
    if(Data.password != null || Data.password != null){

      if(Data.password.isNotEmpty || Data.username.isNotEmpty ||
          Data.school != null)
      {
        Data.password = '';
        Data.username = '';
        Data.school = null;
      }
    }

    if(StudentData.Instance != null){

      if(StudentData.Instance.username != null ||
          StudentData.Instance.password != null ||
          StudentData.Instance.training.isNotEmpty)
      {

        if(StudentData.Instance.password.isNotEmpty ||
          StudentData.Instance.username.isNotEmpty){
            StudentData.setInstance('', '', null);
          }
      }
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
      )
    );

  }
}