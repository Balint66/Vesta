import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/loginpage/schoolSelectioButton.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/loginpage/loginButton.dart';
import 'package:vesta/datastorage/school/schoolList.dart';
import 'package:vesta/messaging/messageManager.dart';
import 'package:vesta/web/webServices.dart';

import '../Vesta.dart';

class Authorization extends StatefulWidget
{

  const  Authorization({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState()
  {
    return new AuthorizationState();
  }

}

class AuthorizationState extends State<Authorization>
{
  Future<SchoolList> _post;

  final TextEditingController userName = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final LoginButton login = new LoginButton();

  @override
  void initState() {
    super.initState();
    _post = WebServices.fetchSchools();

    clearData();
  }

  void clearData()
  {
    if(Data.password != null || Data.password != null){

      if(Data.password.isNotEmpty || Data.username.isNotEmpty ||
          Data.school != null)
      {
        Data.password = "";
        Data.username = "";
        Data.school = null;
      }
    }

    if(StudentData.Instance != null){

      if(StudentData.Instance.username != null ||
          StudentData.Instance.password != null ||
          StudentData.Instance.training.isNotEmpty)
      {

        if(StudentData.Instance.password.isNotEmpty ||
            StudentData.Instance.username.isNotEmpty)
          StudentData.setInstance("", "", null);
      }
    }
  }

  @override
  Widget build(BuildContext context)
  {

    if(_post == null)
      _post = WebServices.fetchSchools();

    return Scaffold(
        body: MessageManager(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                      future: _post,
                      builder: (context,snapshot)
                      {

                        if(snapshot.hasData)
                        {

                          return SchoolSelectionButton(snapshot.data);

                        }
                        else if(snapshot.hasError)
                        {

                          Vesta.showSnackbar(new Text("${snapshot.error}"));
                          return new MaterialButton(
                            onPressed: ()
                              {
                                this.reassemble();
                              },
                            child: Text("Újra próbálkozás"),);

                        }

                        return CircularProgressIndicator();

                      },
                    ),
                    Container(
                      child: TextField(
                        autocorrect: false,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          hintText: "Neptun Code",),
                        maxLines: 1,
                        controller: userName,
                        onChanged: (str)
                        {
                          Data.username = userName.text;
                        },),
                      width: 300.0,),
                    Container(
                        child: TextField(
                          autocorrect: false,
                          decoration: const InputDecoration(labelText: "password"),
                          obscureText: true,
                          maxLines: 1,
                          controller: password,
                          onChanged: (str)
                          {
                            Data.password = password.text;
                          },),
                        width: 300.0),
                    login,
                  ]
              )
          )
        )
    )
    ;

  }
}