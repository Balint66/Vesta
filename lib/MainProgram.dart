import 'package:flutter/material.dart';
import 'package:vesta/Vesta.dart';

class MainProgram extends StatefulWidget
{

  const MainProgram({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return MainProgramState();
  }
}

class MainProgramState extends State<MainProgram> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Vesta.showSnackbar = (Widget widget){
      if(widget == null)
        return;
      Scaffold.of(context).showSnackBar(new SnackBar(content: widget));

    };

    // TODO: implement build
    return Center(
        child: FlatButton(
            onPressed: (){ mainController.sink.add(ProgramHolder.auth);},
            child: Text("Hello!")));
  }

}