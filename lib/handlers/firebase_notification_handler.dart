import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/handlers/permission_handler.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.data}');
}

abstract class FirebaseNotifications {
  static FirebaseMessaging? _firebaseMessaging;
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static AndroidNotificationChannel? _channel;

  static init() async {
    log_data(label: "sad", data: "data");
    PermissionHandler().checkNotificationPermission();
    _channel = const AndroidNotificationChannel('high_importance_channel', 'High Importance Notifications', importance: Importance.high, description: 'This channel is used for important notifications.');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.setAutoInitEnabled(true);
    log_data(label: "Fcm tokem", data: (await _firebaseMessaging!.getToken()));
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
    _flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(_channel!);
    _flutterLocalNotificationsPlugin!.initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: DarwinInitializationSettings()));
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    if (Platform.isIOS) _firebaseMessaging!.requestPermission(alert: true, announcement: true, badge: true, sound: true);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log_data(label: "Handling on message", data: message.notification!.title);
      await _flutterLocalNotificationsPlugin!.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(android: AndroidNotificationDetails(_channel!.id, _channel!.name, icon: '@mipmap/ic_launcher', channelDescription: _channel!.description)),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Handling message open app ${message.data}');
    });
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      log('Handling initial message  ${message?.data}');
    });
    _flutterLocalNotificationsPlugin!.getNotificationAppLaunchDetails().then((value) {
      // log('Handling if local notification launch app  ${value!.notificationResponse!.payload}');
    });
  }

  static scheduleNotification(String title, String subtitle) async {
    var rng = math.Random();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails('your channel id', 'your channel name', importance: Importance.high, priority: Priority.high, ticker: 'ticker');
    // var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: DarwinNotificationDetails());
    await _flutterLocalNotificationsPlugin!.show(rng.nextInt(100000), title, subtitle, platformChannelSpecifics, payload: 'item x');
  }
}
