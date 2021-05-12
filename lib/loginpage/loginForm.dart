import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/Lists/schoolList.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/loginpage/keepMeLoggedInButton.dart';
import 'package:vesta/loginpage/loginButton.dart';
import 'package:vesta/loginpage/schoolSelectioButton.dart';
import 'package:vesta/web/webServices.dart';

class LoginForm extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return LoginFormState();
  }

  static LoginFormState of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<_LoginForm>()!.data!;
  }

}

class _LoginForm extends InheritedWidget
{

  final LoginFormState? data;

  _LoginForm({Key? key, @required Widget? child, @required LoginFormState? data})
    : data = data, super(key: key, child: child ?? Container());



  @override
  bool updateShouldNotify(_LoginForm oldWidget) {
    return true;
  }

}

class LoginFormState extends State<LoginForm>
{


  Future<SchoolList?>? _post;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final LoginButton _login = LoginButton();

  String get userName => _userName.value.text;
  String get password => _password.value.text;

  bool _validSchool = false;
  bool _validUsername = false;
  bool _validPassword = false;

  bool _ableToLogin = false;

  bool get ableToLogin => _ableToLogin;

  bool _obscure = true;

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

    Timer.periodic(Duration(seconds: 1), (Timer timer)
    {
      if(_validPassword&&_validUsername&&_validSchool&&!ableToLogin) {
        ableToLogin = true;
      } 
      else if(!(_validSchool&&_validUsername&&_validPassword)&&ableToLogin) {
        ableToLogin = false;
      }
    });

  }

  @override
  Widget build(BuildContext context)
  {

    var translator = AppTranslations.of(context);

    _post ??= WebServices.fetchSchools();

      return _LoginForm(
        data: this,
        child: AutofillGroup(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                  child:FormField<School>(builder: (FormFieldState<School> state)
                {
                  return FutureBuilder(
                    future: Future.delayed(Duration(seconds: 1), () async => await _post),
                    builder: (BuildContext context, AsyncSnapshot<SchoolList?> snapshot)
                    {

                      if(snapshot.hasData)
                      {

                        return SchoolSelectionButton(snapshot.data as SchoolList, state);

                      }
                      else if(snapshot.hasError)
                      {

                        return MaterialButton(
                          onPressed: () => setState(() {
                            _post = null;
                          }),
                          child: Text(translator.translate('login_retry')),);

                      }

                      return CircularProgressIndicator();

                    },
                  );},
                  initialValue: null,
                  onSaved: (School? value)
                  {
                    Data.school = value;
                  },
                  validator: (School? value)
                  {
                    if(value == null)
                    {
                      if(_validSchool) {
                            _validSchool = false;
                      }
                      return translator.translate('login_select_school');
                    }
                    if(!_validSchool) {
                          _validSchool = true;
                    }
                    return null;
                  },
                ), 
                ),
                Container(
                  width: 300.0,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding: EdgeInsets.only(right:30),
                  child:TextFormField(
                    autocorrect: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      icon:Icon(Icons.person_outline_outlined),
                      labelText: translator.translate('login_username'),
                      hintText: translator.translate('login_username_hint'),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1))
                    ),
                    maxLines: 1,
                    controller: _userName,
                    textCapitalization: TextCapitalization.characters,
                    validator: (String? value)
                    {
                      if((value?.isEmpty ?? true )
                      || (((value?.runes.first ?? 0) >= ('0').runes.first) 
                          && ((value?.runes.first ?? 0) <= ('9').runes.first)))
                      {
                        if(_validUsername) {
                          _validUsername = false;
                        }
                        return translator.translate('login_username_character_error');
                      }
                      if(!_validUsername) {
                        _validUsername = true;
                      }
                      return null;
                    },
                  ), 
                  ),
                Container(
                    width: 300.0,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.only(right:30),
                    child: TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_outlined),
                        labelText: translator.translate('login_password'),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                        suffixIcon: Container(
                      padding: EdgeInsets.fromLTRB(10,0,5,0),
                      child: Container(width:40, padding: EdgeInsets.symmetric(vertical:5),
                        child: MouseRegion(onEnter: (item)=>setState((){
                            _obscure = false;
                        }),
                        onExit: (item)=>setState((){
                            _obscure = true;
                        }),
                        child: GestureDetector(onTap: ()=>setState((){
                            _obscure = !_obscure;
                        }),
                        child:  Icon(_obscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                        )
                        ),)
                    )
                      ),
                      obscureText: _obscure,
                      maxLines: 1,
                      controller: _password,
                      validator: (String? value)
                      {
                        if(value?.isEmpty ?? true)
                        {
                          if(_validPassword) {
                              _validPassword = false;
                          }
                          return translator.translate('login_password_error');
                        }
                        if(!_validPassword) {
                            _validPassword = true;
                        }
                        return null;
                      },
                    ),
                ),
                Center( child:Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child:KeepMeLoggedInButton(),)),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: _login,
                ),
              ],
            ),
          ),
        )
      );

  }

}