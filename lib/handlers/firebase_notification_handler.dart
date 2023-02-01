import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.data}');
}

class FirebaseNotificationsHandler {
  FirebaseMessaging? _firebaseMessaging;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  AndroidNotificationChannel? _channel;
  static FirebaseNotificationsHandler? instance;
  FirebaseNotificationsHandler._internal();

  /// for initing the listenrs of the push notifications
  factory FirebaseNotificationsHandler.init() {
    if (instance == null) {
      //for init the notfication listners
      instance = FirebaseNotificationsHandler._internal();
      instance!._channel = const AndroidNotificationChannel('high_importance_channel', 'High Importance Notifications', importance: Importance.high, description: 'This channel is used for important notifications.');
      instance!._firebaseMessaging = FirebaseMessaging.instance;
      instance!._firebaseMessaging!.setAutoInitEnabled(true);
      if (Platform.isIOS) instance!._firebaseMessaging!.requestPermission(alert: true, announcement: true, badge: true, sound: true);

      // for init the locale notification
      instance!._flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      instance!._flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
      instance!._flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(instance!._channel!);
      instance!._flutterLocalNotificationsPlugin!.initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: DarwinInitializationSettings()));
      instance!._flutterLocalNotificationsPlugin!.getNotificationAppLaunchDetails().then((value) {
        // log('Handling if local notification launch app  ${value!.notificationResponse!.payload}');
      });
    }
    if (SharedHandler.instance!.getData(key: SharedKeys().notificationInited, valueType: ValueType.bool) == false) {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        log_check(label: "Message Content check", currentValue: message.data.isNotEmpty, expectedValue: true);
        log_data(label: "Medssage Content", message: message.notification!.android!.imageUrl);

        instance!._flutterLocalNotificationsPlugin!.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              instance!._channel!.id,
              instance!._channel!.name,
              icon: '@mipmap/ic_launcher',
              channelDescription: instance!._channel!.description,
              
            ),
          ),
        );
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log_data(label: "Notification opening", message: "Opened from the notification");
      });
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        log('Handling initial message  ${message?.data}');
      });

      instance!._firebaseMessaging!.getToken().then((value) {
        log_data(label: "Fcm token", message: value);
        return SharedHandler.instance!.setData(SharedKeys().fcmToken, value: value);
      });
      SharedHandler.instance!.setData(SharedKeys().notificationInited, value: true);
    }

    return instance!;
  }

  /// for shoing local notification
  scheduleNotification(String title, String subtitle) async {
    var rng = math.Random();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails('your channel id', 'your channel name', importance: Importance.high, priority: Priority.high, ticker: 'ticker');
    // var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: DarwinNotificationDetails());
    await instance!._flutterLocalNotificationsPlugin!.show(rng.nextInt(100000), title, subtitle, platformChannelSpecifics, payload: 'item x');
  }

  getToken() {}
}
