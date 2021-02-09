import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vesta/datastorage/Lists/schoolList.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/local/persistentDataManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/fetchManager.dart';
import 'package:vesta/web/webServices.dart';

class AccountSettings extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => AccountSettingsState();

}

class AccountSettingsState extends State<AccountSettings>
{
  @override
  Widget build(BuildContext context) 
  {

    var translator = AppTranslations.of(context);

    var options = <Widget>[
      ListTile(title: Text(translator.translate('settings_logout')),
          onTap: ()
          {
            FileManager.clearLoginFileData();
            FetchManager.clearRegistered();
            AccountManager.removeCurrentAcount();
            if(AccountManager.acountsCount == 0)
            {
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            }
          },),
          ListTile(
            title: Text(translator.translate('settings_schools_privacy')),
            onTap: ()=>showDialog(context: context, builder:(ctx)=>Dialog(child: FutureBuilder(
              future: WebServices.getSchoolsPrivacyPolicy(AccountManager.currentAcount.school),
              builder: (context, snapshot) 
              {
                if(snapshot.hasError) {
                  return SingleChildScrollView(child: Center(child: Text(snapshot.error!.toString())));
                }

                if(!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return Center(child:Text('${snapshot.data}'));

              },
            ))),
          ),
    ];

    return Scaffold(appBar: AppBar(title: Text(translator.translate('settings_school'))),
      body: ListView(children: options)
    );
  }

}