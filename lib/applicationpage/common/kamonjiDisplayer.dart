import 'package:flutter/widgets.dart';

class KamonjiDisplayer extends StatelessWidget
{

  final RichText text;

  KamonjiDisplayer(this.text);

  @override
  Widget build(BuildContext context) 
  {
    return LayoutBuilder(builder: (context, viewport)
    {
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewport.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: 
              [
                Expanded(child: Container(child: Center(child: text), ), )
              ],
            ),
          )
        ),
      );
    });
  }

}