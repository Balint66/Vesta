import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/school/schoolList.dart';
import 'package:vesta/loginpage/keepMeLoggedInButton.dart';
import 'package:vesta/loginpage/loginButton.dart';
import 'package:vesta/loginpage/schoolSelectioButton.dart';
import 'package:vesta/web/webServices.dart';

class LoginForm extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return new LoginFormState();
  }

  static LoginFormState of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<_LoginForm>().data;
  }

}

class _LoginForm extends InheritedWidget
{

  final LoginFormState data;

  _LoginForm({Key key, @required Widget child, @required LoginFormState data})
    : this.data = data, super(key: key, child: child);



  @override
  bool updateShouldNotify(_LoginForm oldWidget) {
    return true;
  }

}

class LoginFormState extends State<LoginForm>
{


  Future<SchoolList> _post;

  final TextEditingController _userName = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final LoginButton _login = new LoginButton();

  bool _validSchool = false;
  bool _validUsername = false;
  bool _validPassword = false;

  bool _ableToLogin = false;

  bool get ableToLogin => _ableToLogin;

  set ableToLogin(bool value)
  {
    setState(() {
      _ableToLogin = value;
    });
  }

  @override
  void initState()
  {
    super.initState();

    Future.doWhile(() async
    {
      await Future.delayed(new Duration(seconds: 1));

      if(_validPassword&&_validUsername&&_validSchool&&!ableToLogin)
        ableToLogin = true;
      else if(!(_validSchool&&_validUsername&&_validPassword)&&ableToLogin)
        ableToLogin = false;

      return true;
    });

  }

  @override
  Widget build(BuildContext context)
  {

    if(_post == null)
      _post = WebServices.fetchSchools();

      return _LoginForm(
        data: this,
        child: new  Form(
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormField<School>(builder: (FormFieldState state)
              {
                return FutureBuilder(
                  future: Future.delayed(new Duration(seconds: 1), ()=>_post),
                  builder: (BuildContext context, AsyncSnapshot<SchoolList> snapshot)
                  {

                    if(snapshot.hasData)
                    {

                      return SchoolSelectionButton(snapshot.data, state);

                    }
                    else if(snapshot.hasError)
                    {

                      return new MaterialButton(
                        onPressed: () => setState(() {
                          _post = null;
                        }),
                        child: Text("Újra próbálkozás"),);

                    }

                    return CircularProgressIndicator();

                  },
                );},
                initialValue: null,
                onSaved: (School value)
                {
                  Data.school = value;
                },
                validator: (School value)
                {
                  if(value == null)
                  {
                    if(_validSchool)
                      _validSchool = false;
                    return "Please select school!";
                  }
                  if(!_validSchool)
                    _validSchool = true;
                  return null;
                },
              ),
              Container(
                child: TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    hintText: "Neptun Code",),
                  maxLines: 1,
                  controller: _userName,
                  onChanged: (str)
                  {
                    Data.username = _userName.text;
                  },
                  validator: (String value)
                  {
                    if(value.isEmpty || value.length < 6)
                    {
                      if(_validUsername)
                        _validUsername = false;
                      return "Username must be at least 6 character long!";
                    }
                    if(!_validUsername)
                      _validUsername = true;
                    return null;
                  },
                ),
                width: 300.0,),
              Container(
                  child: TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(labelText: "password"),
                    obscureText: true,
                    maxLines: 1,
                    controller: _password,
                    onChanged: (str)
                    {
                      Data.password = _password.text;
                    },
                    validator: (String value)
                    {
                      if(value.isEmpty)
                      {
                        if(_validPassword)
                          _validPassword = false;
                        return "Password must not be empty!";
                      }
                      if(!_validPassword)
                        _validPassword = true;
                      return null;
                    },
                  ),
                  width: 300.0),
              new KeepMeLoggedInButton(),
              new Container(
                child: _login,
                padding: EdgeInsets.only(top: 20),
              ),
            ],
          ),
        ),
      );

  }

}