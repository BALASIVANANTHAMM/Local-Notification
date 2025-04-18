import 'package:flutter/material.dart';
import 'local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Notification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Local Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.title,style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange
              ),
                onPressed: (){
              NotificationService.instance.instantNotificationTrigger(
                  title: 'Instant Notification',
                  body: 'Instantly Received Notification'
              );
            }, child: Text("Instant Notification",style: TextStyle(color: Colors.white),)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange
                ),
                onPressed: (){
              NotificationService.instance.scheduledNotificationTrigger(
                  content: 'Scheduled after 5 seconds when pressed'
              );
            }, child: Text("Scheduled Notification",style: TextStyle(color: Colors.white),)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange
                ),
                onPressed: (){
              NotificationService.instance.periodicallyShowBetweenIntervalNotificationTrigger(
                  content: 'Periodically show every minute interval'
              );
            }, child: Text("Periodic Notification",style: TextStyle(color: Colors.white),)),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
