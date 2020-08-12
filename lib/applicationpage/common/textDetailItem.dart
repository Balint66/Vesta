import 'package:flutter/widgets.dart';

import 'genericDetailItem.dart';

class TextDetailItem extends DetailItem
{
  TextDetailItem(String category, String item) : super(category, Text(item));
}