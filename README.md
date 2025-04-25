📢 Flutter Local Notifications
A Flutter application demonstrating how to implement local notifications using the flutter_local_notifications package.

📝 Features
Schedule notifications

Show instant notifications

Custom notification sounds

Handle notification interactions

Notification with action buttons

🚀 Installation & Setup
1️⃣ Add Dependency
Add the package to your pubspec.yaml file:

yaml
dependencies:
  flutter_local_notifications: latest_version
Then, run:

sh
flutter pub get
2️⃣ Android Setup
Modify AndroidManifest.xml to request notification permissions:

xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
3️⃣ iOS Setup
For iOS, update Info.plist with:

xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
🎯 Usage
Initialize Notifications
dart
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosSettings = DarwinInitializationSettings();
  
  var initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  flutterLocalNotificationsPlugin.initialize(initSettings);
}
Show a Notification
dart
void showNotification() async {
  var androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Local Notification',
    'Description of notification',
    importance: Importance.high,
    priority: Priority.high,
  );
  
  var iosDetails = DarwinNotificationDetails();
  
  var details = NotificationDetails(android: androidDetails, iOS: iosDetails);
  
  await flutterLocalNotificationsPlugin.show(
    0, 
    'Hello!', 
    'This is a local notification.', 
    details,
  );
}


💡 References
flutter_local_notifications package

Official Flutter documentation

🛠️ License
This project is licensed under the MIT License.

Feel free to use, modify, and contribute! 🚀
