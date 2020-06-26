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
            buildAsync: true,
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

      var isDark = Theme.of(ctx).brightness == Brightness.dark;

      List<Widget> nextChildren = List.of(children);

      for(var i = 0; i < children.length; i++)
      {


        if(nextChildren[i] is RichText)
        {

          var rt = nextChildren[i] as RichText;

          var reg = RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
          if(reg.hasMatch(rt.text.toPlainText()))
          {

            bool found = false;

            rt.text.visitChildren((span)
            {

              if(span is TextSpan)
              {
                var text = span as TextSpan;

                text.text.padLeft(text.text.length + 7);
                text.text.replaceFirst("       ", "mailto:");

                Vesta.logger.d(text.recognizer);

                found = !found;

              }

              return !found;
            });
          }

        }

      }

    return nextChildren;

    });

    return superWidget;
      
  }

}