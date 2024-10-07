// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'local_notification_service.dart';

// class PushNotificationService {
//   static final PushNotificationService _instance = PushNotificationService._internal();
//   PushNotificationService._internal();
//   factory PushNotificationService() => _instance;

//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> removeFirebaseToken() async {
//     return firebaseMessaging.deleteToken();
//   }

//   Future<String> getDeviceToken() async {
//     try {
//       return await firebaseMessaging.getToken() ?? '';
//     } catch (e) {
//       return '';
//     }
//   }

//   init() async {
//     String deviceToken = await getDeviceToken();
//     Logger().d(deviceToken);
//     if (Platform.isIOS) {
//       firebaseMessaging.requestPermission(alert: true);
//     } else {
//       bool isDenied = await Permission.notification.isDenied;
//       bool isPermanentlyDenied = await Permission.notification.isPermanentlyDenied;
//       if (isDenied || isPermanentlyDenied) {
//         Permission.notification.request();
//       }
//     }
//   }

//   void onFirebaseMessageReceive() {
//     // Executes when app is in foreground

//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage message) {
//         Logger().d(':::::::::: Executes when app is in foreground');
//         LocalNotificationService.display(message);
//       },
//     );
//   }

//   void onFirebaseNotificationTapWhenAppInBackground(BuildContext context) {
//     // Executes when app is in background and tapped
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       Logger().d(':::::::::: Executes when app is in background and tapped');
//       LocalNotificationService.onNotificationTap(
//         message: message,
//         methodName: 'background',
//       );
//     });
//   }

//   void onFirebaseNotificationTapWhenAppIsKill(BuildContext context) {
//     // Executes when app is in kill
//     firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         Logger().d(':::::::::: Executes when app is in kill');
//         LocalNotificationService.onNotificationTap(
//           message: message,
//           methodName: 'kill',
//         );
//       }
//     });
//   }
// }
