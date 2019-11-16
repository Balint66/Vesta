import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:vesta/StudentData.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/schoolList.dart';
import 'package:html_unescape/html_unescape.dart';

class WebServices
{

  static final http.Client client = testWeb();

  static final HtmlUnescape unescape = new HtmlUnescape();

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

    String body = json.encode({"OnlyLogin":false, "TotalRowCount":-1,
      "ExceptionsEnum":0,"UserLogin":userName,"Password":password,
      "Neptuncode":null,"CurrentPage":0, "StudentTrainingID":null,
      "LCID":1038,"ErrorMessage":null,"MobileVersion":"1.5",
      "MobileServiceVersion":0,});

    http.Response resp = await client.post(school.Url + "/GetTrainings",
        headers: {"content-type":"application/json"},body: body);

    Map<String, dynamic> respBody = json.decode(resp.body);

    _testResponse(respBody);

    if(respBody["TrainingList"]==null)
      throw "There isn' any associated training for this student";



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

  static Future getMessages(School school, StudentData student) async
  {

    String body = json.encode({"OnlyLogin":false, "TotalRowCount":-1,
      "ExceptionsEnum":0,"UserLogin":student.username,
      "Password":student.password,
      "Neptuncode":student.username,"CurrentPage":0,
      "StudentTrainingID":student.currentTraining.id,
      "LCID":1038,"ErrorMessage":null,"MobileVersion":"1.5",
      "MobileServiceVersion":0,});

    http.Response resp = await client.post(school.Url + "/GetMessages",
        headers: {"content-type":"application/json"},body: body);


    Map<String,dynamic> jsonBody = json.decode(resp.body);

    print(DateTime.fromMillisecondsSinceEpoch(int.parse(((jsonBody["MessagesList"][0] as Map<String,dynamic>)["SendDate"] as String).substring(6).split(')')[0])));

    return true;

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