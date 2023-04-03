import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  Future<void> initialize() async{
    const AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("@drawable/flutter_icon");

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {}
    );
    var initializationSettings = InitializationSettings(
        android:initializationSettingsAndroid,iOS: initializationSettingsIOS
    );
    final InitializationSettings settings = InitializationSettings(
      android:initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );
    await _localNotificationService.initialize(settings);
  }

}