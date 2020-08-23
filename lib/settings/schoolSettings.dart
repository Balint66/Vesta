import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/local/fileManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

class SchoolSettings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => SchoolSettingsState();

}

class SchoolSettingsState extends State<SchoolSettings>
{
  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);

    var options = <Widget>[
      ListTile(title: Text(translator.translate('settings_logout')),
          onTap: ()
          {
            FileManager.clearFileData();
            FetchManager.clearRegistered();
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          },),
          ListTile(
            title: Text(translator.translate('settings_schools_privacy')),
            onTap: ()=>showDialog(context: context, builder:(ctx)=>Dialog(child: FutureBuilder(
              future: WebServices.getSchoolsPrivacyPolicy(Data.school),
              builder: (context, snapshot) 
              {
                if(snapshot.hasError) {
                  return SingleChildScrollView(child: Center(child: Text(snapshot.error)));
                }

                if(!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return Center(child:Text('${snapshot.data}'));

              },
            ))),
          ),
    ];

    return Scaffold(appBar: AppBar(title: Text('School Settings')),
      body: ListView(children: options)
    );
  }

}