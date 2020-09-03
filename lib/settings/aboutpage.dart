import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vesta/i18n/appTranslations.dart';

class AboutPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {

    final translator = AppTranslations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(translator.translate('settings_about'))),
      body: ListView(
        children: [
          ListTile(title: Text(translator.translate('settings_privacy')),),
          ListTile(leading: SvgPicture.network('https://www.ko-fi.com/img/cup.svg', width: 25,), title: Text(translator.translate('settings_kofi')), onTap: ()=> launch('www.ko-fi.com/projecttorok'),)
        ],
      )
    ); 
  }

}