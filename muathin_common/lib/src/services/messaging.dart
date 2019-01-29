import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:muathin_common/src/models/notification_model.dart';

class Messaging {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  FirebaseMessaging get firebaseMessaging => this._firebaseMessaging;
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      this._flutterLocalNotificationsPlugin;

  initMessaging() {
    AndroidInitializationSettings forAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    IOSInitializationSettings forIOS = new IOSInitializationSettings();
    InitializationSettings initializationSettings =
        new InitializationSettings(forAndroid, forIOS);
    this.flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: this.onSelectNotification);
  }

  Future onSelectNotification(String s) async {
    print(s);
  }

  requestNotificationIOS() {
    this.firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, alert: true, badge: true));
    this
        .firebaseMessaging
        .onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("FirebaseMessaging Settings: $settings");
    });
  }

  configureMessaging() {
    this.firebaseMessaging.getToken().then((token) {
//      print('FirebaseMessaging Token: $token');
    });

    this.firebaseMessaging.configure(onMessage: (m) async {
      print('FirebaseMessaging onMessage: $m');
      NotificationModel n =
          NotificationModel().transform(map: m['notification']);
      this.showNotification(n);
    }, onLaunch: (m) async {
      print('FirebaseMessaging onLaunch: $m');
      NotificationModel n =
          NotificationModel().transform(map: m['notification']);
      this.showNotification(n);
    }, onResume: (m) async {
      print('FirebaseMessaging onResume: $m');
      NotificationModel n =
          NotificationModel().transform(map: m['notification']);
      this.showNotification(n);
    });
  }

  Future showNotification(NotificationModel n) async {
    AndroidNotificationDetails forAndroid = new AndroidNotificationDetails(
        'channelID', 'channelName', 'channelDesc');
    IOSNotificationDetails forIOS = new IOSNotificationDetails();
    NotificationDetails notificationDetails =
        new NotificationDetails(forAndroid, forIOS);
    await this.flutterLocalNotificationsPlugin.show(
        0, n.title, n.body, notificationDetails,
        payload: 'Default_Sound');
  }
}
