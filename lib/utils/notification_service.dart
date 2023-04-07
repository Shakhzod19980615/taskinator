import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../db/db_helper.dart';
import '../model/task_model.dart';

class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> initNotification() async{
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@drawable/todo_icon");
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
    _configureLocalTimeZone();
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
     id=0,  title,  body,
    required  time,
    String? payLoad,
} ) async{
  return await notificationsPlugin.show(id, title, body, notificationDetails(),);
}
  Future<void> showScheduledNotification(int hour,int minutes,TaskModel taskModel) async{

    return await notificationsPlugin.zonedSchedule(
        taskModel.id!!,
        taskModel.task_title,
        " Bismillah bilan boshlang :)",
        _convertTime(hour,minutes),
        //tz.TZDateTime.now(tz.local),
        /*tz.TZDateTime.local(DateTime.now().year,DateTime.now().month,DateTime.now().day,
            DateTime.now().hour+5,DateTime.now().minute+1),*/
        notificationDetails(), uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
  tz.TZDateTime _convertTime(int hour,int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = 
        tz.TZDateTime(tz.local, now.year,now.month,now.day,hour,minutes);
    return scheduleDate;
  }
  Future <void> _configureLocalTimeZone() async{
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
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
/* tz.TZDateTime nextInstanceOf(String? taskDate) {
    var name = timezoneNames[DateTime.now().timeZoneOffset.inMilliseconds];
    final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(name));
    return tz.TZDateTime(
        tz.getLocation(name), int.parse(taskDate!), now.millisecond);
  }*/


}

Map timezoneNames = {
  0: 'UTC',
  10800000: 'Indian/Mayotte',
  3600000: 'Europe/London',
  7200000: 'Europe/Zurich',
  -32400000: 'Pacific/Gambier',
  -28800000: 'US/Alaska',
  -14400000: 'US/Eastern',
  -10800000: 'Canada/Atlantic',
  -18000000: 'US/Central',
  -21600000: 'US/Mountain',
  -25200000: 'US/Pacific',
  -7200000: 'Atlantic/South_Georgia',
  -9000000: 'Canada/Newfoundland',
  39600000: 'Pacific/Pohnpei',
  25200000: 'Indian/Christmas',
  36000000: 'Pacific/Saipan',
  18000000: 'Indian/Maldives',
  46800000: 'Pacific/Tongatapu',
  21600000: 'Indian/Chagos',
  43200000: 'Pacific/Wallis',
  14400000: 'Indian/Reunion',
  28800000: 'Australia/Perth',
  32400000: 'Pacific/Palau',
  19800000: 'Asia/Kolkata',
  16200000: 'Asia/Kabul',
  20700000: 'Asia/Kathmandu',
  23400000: 'Indian/Cocos',
  12600000: 'Asia/Tehran',
  -3600000: 'Atlantic/Cape_Verde',
  37800000: 'Australia/Broken_Hill',
  34200000: 'Australia/Darwin',
  31500000: 'Australia/Eucla',
  49500000: 'Pacific/Chatham',
  -36000000: 'US/Hawaii',
  50400000: 'Pacific/Kiritimati',
  -34200000: 'Pacific/Marquesas',
  -39600000: 'Pacific/Pago_Pago'
};

