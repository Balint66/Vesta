import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/widgets.dart';
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
import 'package:cookie_jar/cookie_jar.dart';

typedef _ServicesCallback = Future<Object> Function<T extends WebDataBase>(School school ,T request);
typedef _VoidFutureCallback = Future<void> Function();

abstract class WebServices
{

  factory WebServices._() => null;

  static final Dio client = _getClient();
  
  static final CookieManager _cookieManager = new CookieManager(new CookieJar());

  static Dio _getClient()
  {
    Dio client = new Dio(new BaseOptions(
      headers: {"Content-Type":"Application/json"
      },

    ));

    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client)
    {
      client.badCertificateCallback = (cert,host,port) => true;
    };

    client.interceptors.add(_cookieManager);

    return client;

  }

  static final List<_VoidFutureCallback> _callbacks = new List();

  static final Future _loop = Future.doWhile(() async
  {

    await Future.delayed(new Duration(milliseconds: 50));

    if(_callbacks.length != 0)
    {
      await _callbacks[0]();
      _callbacks.removeAt(0);
    }

    return true;

  });

  static void init()
  {
    _loop.then((value) => null);
  }

  static Future<T> _callFunction<T>(_ServicesCallback callback,School school , WebDataBase request) async
  {
    Object obj;

    _VoidFutureCallback clb = () async
    {
      obj = await callback(school, request);
    };

    _callbacks.add(clb);

    await Future.doWhile(() async
    {

      await Future.delayed(new Duration(milliseconds: 50));

      return obj == null;
    });

    return obj as T;

  }

  static Future<SchoolList> fetchSchools() async
  {

    return await _callFunction<SchoolList>(_fetchSchools, null, null);

  }

  static Future<SchoolList> _fetchSchools<T extends WebDataBase>(School school, WebDataBase request) async
  {
    String url = Uri.https("mobilecloudservice.cloudapp.net",
        "/MobileServiceLib/MobileCloudService.svc/GetAllNeptunMobileUrls")
        .toString();

    Response resp;
    try{
      resp = await client.post(url,data:"{}");
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


    return SchoolList.fromJson(json.encode(resp.data));

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

    Response resp = await client.post(school.Url + "/GetTrainings",
        data: login.toJson());

    Map<String, dynamic> respBody = resp.data;

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

    return await _callFunction(_getMessages, school, body);

  }

  static Future<WebDataMessages> _getMessages<T extends WebDataBase>(School school, WebDataBase body) async
  {
    Response resp = await client.post(school.Url + "/GetMessages",
        data: body.toJson());


    Map<String,dynamic> jsonBody = resp.data;

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

    return await _callFunction(_setRead, school, body);

  }

  static Future<bool> _setRead<T extends WebDataBase>(School school, T body) async
  {

    try{

      Response resp = await client.post(school.Url + "/SetReadedMessage",
        data: body.toJson(),);

      Map<String,dynamic> jsonBody = resp.data;

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

    return await _callFunction<WebDataCalendarResponse>(_getCalendarData, school, body);

  }

  static Future<WebDataCalendarResponse> _getCalendarData<T extends WebDataBase>
      (School school, T body) async
  {
    try
    {

      Vesta.logger.d("Never gonna give you up.");

      Response resp = await client.post(school.Url + "/GetCalendarData",
          data: body.toJson(),);

      Vesta.logger.d("Never gonna let you down.");

      Map<String, dynamic> jsonMap = resp.data;

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
                  () async => await getCalendarData(school, body as WebDataCalendarRequest));

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

}