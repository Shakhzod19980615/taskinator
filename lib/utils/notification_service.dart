import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> initNotification() async{
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@drawable/flutter_icon");
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
    await notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async{});
    tz.initializeTimeZones();
  }


  notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails("channelId", "channelName",
        importance: Importance.max,
      channelDescription: "description",
      playSound: true),
      iOS: DarwinNotificationDetails()

    );
  }

  Future<void>   showNotification ({
    int id=0, String? title, String? body, String? payLoad
} ) async{
  return await notificationsPlugin.show(id, title, body, notificationDetails());
}
  Future<void> showScheduledNotification({int id=0, String? title, String? body, String? payLoad, required int seconds}) async{
    return await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(DateTime.now().add(Duration(seconds: seconds)), tz.local),
        notificationDetails(), uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
  Future<void>   showNotificationWithPayLoad ({
    int id=0, String? title, String? body, String? payLoad
   } ) async{
    return await notificationsPlugin.show(id, title, body,payload:payLoad, notificationDetails());
  }
  void onSelectNotification(String? payload){
    if(payload != null && payload.isNotEmpty){
      onNotificationClick.add(payload);
    }
  }
}

