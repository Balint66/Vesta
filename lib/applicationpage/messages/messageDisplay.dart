import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vesta/Vesta.dart';

class MessageDisplay extends StatelessWidget
{

  final String sender;
  final String subject;
  final String message;

  MessageDisplay(this.sender,this.subject,this.message);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: new AppBar(title: new Text(sender),),
      body: SingleChildScrollView(child: Column(children: <Widget>[
        new Center( child: new Text(subject,style: new TextStyle(fontSize: 16),)),
        new Linkify(
            text:message,
            humanize: true,
            style: TextStyle(fontSize: 16),
            onOpen: (url) async
            {
              if(await canLaunch(url))
                await launch(url);
              else
                Vesta.showSnackbar(Text("Could not launch url: $url"));
            },
        )
      ],
      ),
    )
    );
  }

}