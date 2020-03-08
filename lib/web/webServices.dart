import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/school/schoolList.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataLogin.dart';
import 'package:vesta/web/webdata/webDataMessages.dart';

class WebServices
{

  static final http.Client client = testWeb();

  static Future<SchoolList> fetchSchools() async
  {

    String url = Uri.https("mobilecloudservice.cloudapp.net",
        "/MobileServiceLib/MobileCloudService.svc/GetAllNeptunMobileUrls")
        .toString();

    http.Response resp;
    try{
     resp = await client.post(url,body:"{}"
       ,headers:{"Content-Type":"Application/json"
       },);
    }
    catch(e)
    {

      if(e is SocketException)
      {
        SocketException exp = e;
        if(exp.osError.errorCode == 7)
        {
          throw "Unable to connect to the internet";
        }
      }
      else
      {
        print(e.toString());
      }

      throw e;

    }


    return SchoolList.fromJson(resp.body);

  }

  static Future<bool> login(String userName, String password, School school) async
  {
    try{

    if(school == null)
      throw "Please chose a school!";
    if(userName == null || userName.isEmpty)
      throw "Please give a valid username!";
    if(password == null || password.isEmpty)
      throw "Please type in a valid password!";

    WebDataLogin login = WebDataLogin.simplifiedOnly(userName, password);

    http.Response resp = await client.post(school.Url + "/GetTrainings",
        headers: {"content-type":"application/json"},body: login.toJson());

    Map<String, dynamic> respBody = json.decode(resp.body);

    _testResponse(respBody);

    if(respBody["TrainingList"]==null)
      throw "There isn't any associated training for this student";



    StudentData.setInstance(userName, password,
        TrainingData.listFromJsonString(json.encode(respBody["TrainingList"])));

    return true;

    }
    catch(e)
    {
      Vesta.showSnackbar(new Text("$e"));
    }
    
    return false;

  }

  static Future<WebDataMessages> getMessages(School school, StudentData student) async
  {

    WebDataBase body = WebDataBase.simplified(student.username, student.password, student.username, student.currentTraining.id);

    http.Response resp = await client.post(school.Url + "/GetMessages",
        headers: {"content-type":"application/json"},body: body.toJson());


    Map<String,dynamic> jsonBody = json.decode(resp.body);

    try
    {
      _testResponse(jsonBody);
    }
    catch(e)
    {
      Vesta.logger.e(e);
      return null;
    }

    return WebDataMessages.fromJson(jsonBody);

  }

  static Future<bool> setRead(School school, StudentData student, String id) async
  {
    String body = json.encode({"PersonMessageId":id,"TotalRowCount":-1,
      "ExceptionsEnum":0,"UserLogin":student.username,
      "Password":student.password,
      "Neptuncode":student.username,"CurrentPage":0,
      "StudentTrainingID":student.currentTraining.id,
      "LCID":1038,"ErrorMessage":null,"MobileVersion":"1.5",
      "MobileServiceVersion":0,});

    try{

    http.Response resp = await client.post(school.Url + "/SetReadedMessage",body: body,headers: {"content-type":"application/json"},);

    Map<String,dynamic> jsonBody = json.decode(resp.body);

    _testResponse(jsonBody);

    return true;

    }
    catch(e)
    {

      Vesta.logger.e(e);
      return false;

    }

  }

  static void _testResponse(Map<String, dynamic> jsonBody)
  {
    if(jsonBody["ExceptionData"] != null || jsonBody["ErrorMessage"] != null)
    {
      if(jsonBody["ExceptionData"] == null)
        throw jsonBody["ErrorMessage"];
      throw jsonBody["ExceptionData"];
    }

  }

  static http.Client testWeb()
  {
    try
    {
      Platform.version;
      HttpClient cl = new HttpClient();
      cl.badCertificateCallback = (cert, a, b)=>true;
      return IOClient(cl);
    }
    catch( e)
    {

      dynamic client = http.Client();

      client.withCredentials = true;

      return client;
    }
  }

}