import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
        new Center( child: new Text(subject,style: new TextStyle(fontSize: 26),)),
        new HtmlWidget(
            message.replaceAll('\n', "</br>"),
            textStyle: TextStyle(fontSize: 16),
            onTapUrl: (url) async
            {
              if(await canLaunch(url))
                await launch(url);
              else
                Vesta.showSnackbar(Text("Could not launch url: $url"));
            },
          factoryBuilder: (config)=> new MyFactory(config),
        ),
      ],
      ),
    )
    );
  }

}


class MyFactory extends WidgetFactory
{

  final HtmlWidgetConfig _conf;

  MyFactory(HtmlWidgetConfig config) : this._conf = config, super(config);

  @override
  Iterable<Widget> buildText(BuilderContext bc, Iterable<Widget> _, TextBlock block) {
    List<Widget> ws = List.of(super.buildText(bc, _, block));
    for(int i = 0; i< ws.length; i++)
    {
      if(ws[i] is RichText)
      {

          RichText rt = ws[i] as RichText;

          Color cl = !Vesta.of(bc.context).settings.isDarkTheme ? hyperlinkColor
              : Color.fromARGB(255, 255 - hyperlinkColor.red, 255 - hyperlinkColor.green,
              255 - hyperlinkColor.blue);

          if(rt.text.children?.length != 0 || rt.text.text.contains("http") || rt.text.text.contains("www"))
          {
              ws[i] = new Linkify(text: rt.text.text,
              style: _conf.textStyle, linkStyle: _conf.textStyle.copyWith(color: cl),
                onOpen: _conf.onTapUrl);
          }

      }

    }

    return ws;
  }

}