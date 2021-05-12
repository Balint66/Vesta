import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vesta/applicationpage/common/accountDisplayer.dart';
import 'package:vesta/datastorage/local/persistentDataManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';
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
      GestureDetector(
        onLongPress: ()=>showDialog(context:context, builder:(ctx)
          {
            var accLs = AccountManager.accounts;
            var wLs = <Widget>[...accLs.map((el)=>GestureDetector(
              onTap: (){AccountManager.setAscurrent(el); Navigator.pop(ctx);},
              child: AccountDisplayer(el),
              )).toList()];
            wLs.add(GestureDetector(
              onTap: ()=> Navigator.pushReplacementNamed(ctx, '/login'),
              child: Container(
              height: 100.0,
              child: Icon(FeatherIcons.plusCircle)
              )));
            return SimpleDialog(title: Text('Accounts'), children: wLs);
          },
        ),
        child: AccountDisplayer(AccountManager.currentAccount),
        ),
      ListTile(title: Text(translator.translate('settings_logout')),
          onTap: ()
          {
            AccountManager.currentAccount.deregisterDataHolders();
            AccountManager.removeCurrentAcount();
            if(AccountManager.acountsCount == 0)
            {
              FileManager.clearLoginFileData();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            }
          },),
          ListTile(
            title: Text(translator.translate('settings_schools_privacy')),
            onTap: ()=>showDialog(context: context, builder:(ctx)=>Dialog(child: FutureBuilder(
              future: WebServices.getSchoolsPrivacyPolicy(AccountManager.currentAccount.school),
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

    return Scaffold(appBar: AppBar(title: Text(translator.translate('settings_account'))),
      body: ListView(children: options)
    );
  }

}