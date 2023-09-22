import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPush {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitial = AndroidInitializationSettings('mipmap/launcher_icon');
    var iosInitial = DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitial, iOS: iosInitial);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('test1', 'test2',
            icon: 'mipmap/launcher_icon',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: DarwinNotificationDetails());

    await fln.show(0, title, body, notificationDetails);
  }
}
