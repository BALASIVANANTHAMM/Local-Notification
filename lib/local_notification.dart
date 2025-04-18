import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
_firebaseMessagingBackgroundHandler(NotificationResponse notificationResponse) {}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _localNotifications = FlutterLocalNotificationsPlugin();

  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: _firebaseMessagingBackgroundHandler,
    );
    await _requestPermission();

    // Setup message handlers
    await setupFlutterNotifications();
  }

  Future<void> _requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final bool? grantedNotificationPermission =
    await androidImplementation?.requestNotificationsPermission();
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  instantNotificationTrigger({required String title,required String body})async{
    await _localNotifications.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
          'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  scheduledNotificationTrigger({required String content})async{
    //final scheduledDate = tz.TZDateTime.parse(tz.local,DateFormat('yyyy-MM-dd HH:mm:ss').format(tz.TZDateTime.now(tz.local).add(Duration(seconds: 5))));
    final now = tz.TZDateTime.now(tz.local).toLocal();
    final scheduledTime = now.add(Duration(seconds: 10));
    //final scheduledDate =tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
   await _localNotifications.zonedSchedule(
        1,
        'Scheduled Notification',
        content,
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
            'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),

        ),
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
   print("Trigger Schedule");
   print(scheduledTime);
  }

  periodicallyShowBetweenIntervalNotificationTrigger({required String content})async{
    await _localNotifications.periodicallyShow(
        0,
        'Periodic Notification',
        content,
        RepeatInterval.everyMinute,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
            'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }
}