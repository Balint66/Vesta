import 'package:flutter/material.dart';
import 'package:vesta/Data.dart';
import 'package:vesta/SchoolSelectioButton.dart';
import 'package:vesta/loginButton.dart';
import 'package:vesta/schoolList.dart';

import 'Vesta.dart';

class Authorization extends StatelessWidget
{

  final Future<SchoolList> post;

  final TextEditingController userName = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final LoginButton login = new LoginButton();

  Authorization(this.post,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {

    Vesta.showSnackbar = (Widget widget){
      if(widget == null)
        return;
      Scaffold.of(context).showSnackBar(new SnackBar(content: widget));

    };

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: post,
                builder: (context,snapshot)
                {

                  if(snapshot.hasData)
                  {

                    return SchoolSelectionButton(snapshot.data);

                  }
                  else if(snapshot.hasError)
                  {

                    Vesta.showSnackbar(new Text("${snapshot.error}"));
                    return Text("${snapshot.error}");

                  }

                  return CircularProgressIndicator();

                },
              ),
              Container(
                child: TextField(
                  autocorrect: false,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: "Username",hintText: "Neptun Code",),
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
    );

  }

}