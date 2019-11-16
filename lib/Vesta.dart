import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vesta/Authorization.dart';
import 'package:vesta/sidebar.dart';
import 'package:vesta/webServices.dart';

import 'MainProgram.dart';

StreamController mainController = new StreamController<ProgramHolder>();

class ProgramHolder
{
  final Widget widget;
  final AppBar appbar;

  ProgramHolder(this.widget,this.appbar);

  static final ProgramHolder auth = new ProgramHolder(const Authorization(), null);
  static final ProgramHolder mainProg = new ProgramHolder(const MainProgram(), AppBar(title: Text("Vesta"),));

}

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

  ProgramHolder program = ProgramHolder.auth;

  @override
  void initState()
  {
    
    mainController.stream.listen((data){
      setState(() {
        program = data;
      });
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context)
  {

      return MaterialApp(
          title: "Vesta",
          theme: ThemeData(primarySwatch: Colors.red),
          home: Scaffold(
            appBar: program.appbar,
            drawer: Sidebar(),
            body: program.widget,
          ),
      );

  }

  @override
  void dispose()
  {
    mainController.close();
    super.dispose();
  }

}