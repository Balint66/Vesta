import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vesta/applicationpage/common/accountDisplayer.dart';
import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/datastorage/local/persistentDataManager.dart';
import 'package:vesta/i18n/appTranslations.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/routing/router.dart';
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

    final modal = (AccountData data, BuildContext ctx){
      showModalBottomSheet(context: ctx, builder:(ctx){
        return BottomSheet(
          onClosing: (){},
          builder: (context){
            return ListView(children:[
              ListTile(title: Text(translator.translate('settings_logout')),
                onTap: ()
                {
                  data.deregisterDataHolders();
                  AccountManager.removeAcountWithIndex(AccountManager.accounts.indexOf(data));
                  if(AccountManager.acountsCount == 0)
                  {
                    FileManager.clearLoginFileData();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                },),
                ListTile(
                  title: Text(translator.translate('settings_schools_privacy')),
                  onTap: ()=>showDialog(context: context, builder:(ctx)=>Dialog(child: FutureBuilder(
                    future: WebServices.getSchoolsPrivacyPolicy(data.school),
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
            ]);
          },
        );
      });
    };

    final accLs = AccountManager.accounts.where((e)=>e != AccountManager.currentAccount);

    var wLs = <Widget>[];

    wLs.add(Container(padding: EdgeInsets.fromLTRB(20, 30, 0, 15), child: Text('Current Account:')));

    wLs.add(GestureDetector(
              onTap: ()=>setState((){AccountManager.setAsCurrent(AccountManager.currentAccount);}),
              onLongPress: ()=>modal(AccountManager.currentAccount, context),
              child: AccountDisplayer(AccountManager.currentAccount),
              ));

    wLs.add(Divider());

    wLs.addAll(<Widget>[...accLs.map((el)=>GestureDetector(
              onTap: ()=>setState((){AccountManager.setAsCurrent(el);}),
              onLongPress: ()=>modal(el, context),
              child: AccountDisplayer(el),
              )).toList()]);
    wLs.add(GestureDetector(
              onTap: (){
                MainDelegate.authKey.currentState?.implyLeading = true;
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Container(
              height: 100.0,
              child: Icon(FeatherIcons.plusCircle)
              )));

    return Scaffold(appBar: AppBar(title: Text(translator.translate('settings_account'))),
      body: ListView(children: wLs)
    );
  }

}