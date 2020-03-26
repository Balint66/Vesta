import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/Lists/schoolList.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataCalendarRequest.dart';
import 'package:vesta/web/webdata/webDataCalendarResponse.dart';
import 'package:vesta/web/webdata/webDataLogin.dart';
import 'package:vesta/web/webdata/webDataMessageRead.dart';
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

      Vesta.logger.e(e);

    }


    return SchoolList.fromJson(resp.body);

  }

  static Future<bool> login(String userName, String password, School school, bool keepLoggedIn) async
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

    try
    {

      if(keepLoggedIn)
        await FileManager.saveData();

    }

    catch(e)
    {
      Vesta.logger.d("Seems like we have problems with saving data...");
      Vesta.logger.e(e);
    }

    return true;

    }
    catch(e)
    {
      Vesta.logger.e(e);
      Vesta.showSnackbar(new Text("$e"));
    }
    
    return false;

  }

  static Future<WebDataMessages> getMessages(School school, WebDataBase body) async
  {

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

  static Future<bool> setRead(School school, WebDataMessageRead body) async
  {

    try{

    http.Response resp = await client.post(school.Url + "/SetReadedMessage",
      body: body.toJson(),headers: {"content-type":"application/json"},);

    Map<String,dynamic> jsonBody = json.decode(resp.body);

    _testResponse(jsonBody);

    return true;

    }
    catch(e)
    {

      Vesta.logger.e(body.toJson() + "\n\n" + e.toString());
      return false;

    }

  }

  static Future<WebDataCalendarResponse> getCalendarData(School school,
      WebDataCalendarRequest body) async
  {

    try
    {

      Vesta.logger.d("Never gonna give you up.");
      
      http.Response resp = await client.post(school.Url + "/GetCalendarData",body: body.toJson(), headers: {"content-type":"application/json"});

      Vesta.logger.d("Never gonna let you down.");

      Map<String, dynamic> jsonMap = json.decode(resp.body);

      Vesta.logger.d("Never gonna turn around...");

      _testResponse(jsonMap);

      Vesta.logger.d("To hurt ya'!.");

      return WebDataCalendarResponse.fromJson(jsonMap);
    }
    catch(e)
    {

      //Sometimes Neptun is idiot and can't handle the connection :P
      if(e is String)
        if(e.contains("Connection must be open for this operation")
            || e.contains("Object reference not set to an instance of an object")
            || e.contains("OracleConnection"))
          return await Future.delayed(new Duration(seconds: 1),
                  () async => await getCalendarData(school, body));

      Vesta.logger.e("Something went wrong...\n" + e.toString(),e);
      return null;
    }
  }

  static void _testResponse(Map<String, dynamic> jsonBody)
  {
    if(jsonBody["ExceptionData"] != null || jsonBody["ErrorMessage"] != null)
    {
      if(jsonBody["ExceptionData"] == null)
        throw jsonBody["ErrorMessage"] as String;
      throw jsonBody["ExceptionData"] as String;
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