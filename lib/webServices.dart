import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:vesta/Vesta.dart';

import 'package:vesta/schoolList.dart';

class WebServices
{

  static final http.Client client = testWeb();


  static Future<SchoolList> fetchSchools() async
  {

    String url = Uri.https("mobilecloudservice.cloudapp.net", "/MobileServiceLib/MobileCloudService.svc/GetAllNeptunMobileUrls").toString();

    print("here");

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


    return SchoolList.fromJson(utf8.decode(resp.bodyBytes));

  }

  static Future<bool> login(String userName, String password, School school) async
  {
    try{

    if(school == null)
      throw "Please chose a school!";
    if(userName == null || userName.isEmpty)
      throw "Please give a valid username!";
    if(password == null || password.isEmpty)
      throw "Invalid password!";

    String body = json.encode({"OnlyLogin":false, "TotalRowCount":-1,"ExceptionsEnum":0,"UserLogin":userName,"Password":password,
      "Neptuncode":null,"CurrentPage":0, "StudentTrainingID":null,
      "LCID":37,"ErrorMessage":null,"MobileVersion":"1.5","MobileServiceVersion":0,});

    http.Response resp = await client.post(school.Url + "/GetTrainings",headers: {"content-type":"application/json"},body: body);//*/

    print(resp.body);

    Map<String, dynamic> respBody = json.decode(resp.body);

    if(respBody["ExceptionData"] != null || respBody["ErrorMessage"] != null)
    {
      if(respBody["ExceptionData"] == null)
        throw respBody["ErrorMessage"];
      throw respBody["ExceptionData"];
    }

    if(respBody["StudentTrainingID"]==null)
      throw "There isn' any associated training for this student";

    return true;
    }
    catch(e)
    {
      Vesta.showSnackbar(new Text("$e"));
    }
    
    return false;

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