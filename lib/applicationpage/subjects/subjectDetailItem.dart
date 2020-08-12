import 'package:flutter/material.dart';
import 'package:vesta/applicationpage/common/genericDetailItem.dart';

class SubjectDetailItem extends DetailItem
{
  SubjectDetailItem(String itemCategory, String item) : super(itemCategory, Text(item));
}