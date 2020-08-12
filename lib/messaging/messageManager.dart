import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';


class MessageManager
{

  static final _defaultAndroidDetail = AndroidNotificationDetails('vesta_main', 'Vesta', 'Vesta notifications', importance: Importance.High, priority: Priority.High, ticker: 'ticker');
  static final _defaultIOSDetail = IOSNotificationDetails(presentAlert: true, presentSound: true,);
  static final _notificationDetails = NotificationDetails(_defaultAndroidDetail, _defaultIOSDetail);
  static final _notificationPlugin = _initPlugin();

  static FlutterLocalNotificationsPlugin _initPlugin()
  {
    final android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final ios = IOSInitializationSettings();
    final init = InitializationSettings(android, ios);

    final plugin = FlutterLocalNotificationsPlugin();

    plugin.initialize(init);
    return plugin;
  }

  static void showNotification(String text, {NotificationType type = NotificationType.PLAIN, int splitAtCharacters = 20, String payload})
  {

    switch(type)
    {
      
      case NotificationType.BIGTEXT:
          var detail = NotificationDetails( AndroidNotificationDetails('vesta_main', 'Vesta', 'Vesta notifications', importance: Importance.High,
          priority: Priority.High, ticker: 'ticker', styleInformation: BigTextStyleInformation(text)),
          _defaultIOSDetail);
          _notificationPlugin.show(0, 'Vesta', text, detail, payload: payload);
        break;
      case NotificationType.INBOX:
        
        var ls = List.generate(text.length % splitAtCharacters == 0 ? (text.length ~/ splitAtCharacters) : (text.length ~/ splitAtCharacters) + 1, (i){

          if(i*splitAtCharacters <= text.length)
          {
            return text.substring(i*splitAtCharacters, (i+1)*splitAtCharacters);
          }
          else{
            return text.substring((i)*splitAtCharacters);
          }

        });

        var detail = NotificationDetails(AndroidNotificationDetails('vetsa_main', 'Vesta', 'Vesta notifications', importance: Importance.High,
          priority: Priority.High, ticker: 'ticker', styleInformation: InboxStyleInformation(ls)),
        _defaultIOSDetail);

        _notificationPlugin.show(0, 'Vesta', text, detail);

        break;
      case NotificationType.BIGPICTURE:
        // TODO: Handle this case.
        break;
      case NotificationType.MESSAGING:
      case NotificationType.PLAIN:
      default:
        _notificationPlugin.show(0, 'Vesta', text, _notificationDetails, payload: payload);
      }
      

  }

  static void showSnackBar(Widget message)
  {
    showSimpleNotification(message, duration: Duration(seconds:6));
  }

  static void showToast(String message)
  {
    toast(message);
  }


}

enum NotificationType {
  PLAIN,
  BIGTEXT,
  INBOX,
  BIGPICTURE,
  MESSAGING
}