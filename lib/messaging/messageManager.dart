import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_support/overlay_support.dart';


class MessageManager
{

  static void showSnackBar(Widget message)
  {
    showSimpleNotification(message);
  }

  static void showToast(String message)
  {
    toast(message);
  }


}