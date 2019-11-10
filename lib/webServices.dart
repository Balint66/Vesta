import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'package:http/browser_client.dart';
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
    //HttpClientRequest req = await client.postUrl(Uri.https("mobilecloudservice.cloudapp.net", "/MobileServiceLib/MobileCloudService.svc/GetAllNeptunMobileUrls"));
    //req.headers.add("Content-Type", "Application/json");
    //var resp = await req.close();

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

      //Error error = e;

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

    /*http.Request request = new http.Request("POST", Uri.parse(school.Url));
    request.body = ({"OnlyLogin":true, "TotalRowCount":-1,"ExceptionsEnum":0,"UserLogin":userName,"Password":password,"Neptuncode":null,"CurrentPage":0, "StudentTrainingID":null,
      "LCID":1038,"ErrorMessage":null,"MobileVersion":1.5,"MobileServiceVersion":0}).toString();

    request.headers.addAll({"Content-Type":"Application/json"});*/

    /*await client.send(request);*/

    if(school == null)
      throw "Please chose a school!";
    if(userName == null || userName.isEmpty)
      throw "Please give a valid username!";
    if(password == null || password.isEmpty)
      throw "Invalid password!";
    String body = json.encode({"OnlyLogin":false, "TotalRowCount":-1,"ExceptionsEnum":0,"UserLogin":userName,"Password":password,"Neptuncode":null,"CurrentPage":0, "StudentTrainingID":null,
      "LCID":0,"ErrorMessage":null,"MobileVersion":"1.5","MobileServiceVersion":0,});
    http.Response resp = await client.post(school.Url + "/GetTrainings",headers: {"content-type":"application/json"},body: body);//*/

    print(resp.body);

    Map<String, dynamic> respBody = json.decode(resp.body);

    if(respBody["ExceptionData"] != null || respBody["ErrorMessage"] != null)
    {
      if(respBody["ExceptionData"] == null)
        throw respBody["ErrorMessage"];
      throw respBody["ExceptionData"] != null;
    }

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