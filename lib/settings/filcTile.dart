import 'package:flutter/material.dart';
import 'package:vesta/i18n/appTranslations.dart';

class FilcTile extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {  
    var translator = AppTranslations.of(context);
    return ListTile(title: Text(translator.translate('feltpen_title')), subtitle: Text(translator.translate('feltpen_subtitle')), onLongPress: ()=> showDialog(context: context, builder:(ctx)
    => Dialog(child: Padding(padding: EdgeInsets.all(20), child: Text.rich(TextSpan(text: translator.translate('feltpen_title')+'\n\n', style: TextStyle(fontSize: 20), children: [
      TextSpan(text: translator.translate('feltpen_text'), style: TextStyle(fontSize:14))
    ])),)
    ),)); 
  }

}