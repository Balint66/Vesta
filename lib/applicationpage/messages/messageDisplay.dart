import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
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
                Vesta.showSnackbar(Text("${AppTranslations.of(context).translate("message_urllaunch_error")} $url"));
            },
          factoryBuilder: ()=> new MyFactory(),
        ),
      ],
      ),
    )
    );
  }

}


class MyFactory extends WidgetFactory
{

  MyFactory() : super();

  @override
  Widget buildText(TextBits bits) 
  {

    WidgetPlaceholder superWidget = super.buildText(bits) as WidgetPlaceholder
    ..wrapWith((BuildContext ctx, Iterable<Widget> children, input)
    {

      List<Widget> nextChildren = List.of(children);

      for(var i = 0; i < children.length; i++)
      {
        if(nextChildren[i] is RichText)
        {

            RichText rt = nextChildren[i] as RichText;

            //TODO:Make the coloring correct
            /*Color cl = !Vesta.of(ctx).settings.isDarkTheme ? hyperlinkColor
                : Color.fromARGB(255, 255 - hyperlinkColor.red, 255 - hyperlinkColor.green,
                255 - hyperlinkColor.blue);

            if(rt.text.children?.length != 0 || rt.text.text.contains("http") || rt.text.text.contains("www"))
            {
                nextChildren[i] = new Linkify(text: rt.text.text,
                style: _conf.textStyle, linkStyle: _conf.textStyle.copyWith(color: cl),
                  onOpen: _conf.onTapUrl);

            }*/

        }

      }

    return nextChildren;

    });

    return superWidget;
      
  }

}