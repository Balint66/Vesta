import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/i18n/appTranslations.dart';

class MessageDisplay extends StatelessWidget
{

  final String sender;
  final String subject;
  final String message;

  MessageDisplay(this.sender,this.subject,this.message);

  @override
  Widget build(BuildContext context)
  {

    var reg = RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)');

    if(reg.hasMatch(message))
    {
      var match = reg.allMatches(message);

      match.forEach((element) {
          var ind = message.indexOf(element.group(0));
          message.replaceRange(ind, ind+element.group(0)?.length, 'mailto:' + element.group(0));      
       });

    }

    return Scaffold(
      appBar: AppBar(title: Text(sender),),
      body: SingleChildScrollView(child: Column(children: <Widget>[
        Center( child: Text(subject,style: TextStyle(fontSize: 26),)),
        HtmlWidget(
            message.replaceAll('\n', '</br>'),
            textStyle: TextStyle(fontSize: 16),
            onTapUrl: (url) async
            {
              if(await canLaunch(url)){
                await launch(url);
                }
              else{
                Vesta.showSnackbar(Text("${AppTranslations.of(context).translate("message_urllaunch_error")} $url"));
                }
            },
            buildAsync: true,
        ),
      ],
      ),
    )
    );
  }

}