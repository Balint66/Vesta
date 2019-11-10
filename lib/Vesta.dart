import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vesta/Authorization.dart';
import 'package:vesta/sidebar.dart';
import 'package:vesta/webServices.dart';

import 'MainProgram.dart';

StreamController mainController = new StreamController<Map<String,Widget>>();

final Map<String,Widget> auth = {"widget":Authorization(WebServices.fetchSchools()),"appbar":null};

final Map<String,Widget> mainProg ={"widget":const MainProgram(),"appbar":AppBar(title: Text("Vesta"),)};

class Vesta extends StatefulWidget
{

  static Function showSnackbar = (Widget widget)=>null;

  @override
  State<StatefulWidget> createState()
  {
    return VestaState();
  }

}

class VestaState extends State<Vesta>
{

  @override
  void initState()
  {

    super.initState();

  }

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder<Map<String,Widget>>(initialData: auth,
      stream: mainController.stream,
      builder: (context, snapshot){

      return MaterialApp(
          title: "Vesta",
          theme: ThemeData(primarySwatch: Colors.red),
          home: Scaffold(
            appBar: snapshot.data["appbar"],
            drawer: Sidebar(),
            body: snapshot.data["widget"],
          ),
      );},
    );

  }

  @override
  void dispose()
  {
    mainController.close();
    super.dispose();
  }

}