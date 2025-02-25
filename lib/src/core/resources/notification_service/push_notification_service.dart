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

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oraaq/src/imports.dart';

class NotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int notificationCount = 0;

  void requestNotificationPermissions() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
  //Device toke

  Future<String> getDeviceToken() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    String? token = await firebaseMessaging.getToken();
    debugPrint(token);
    return token!;
  }

  //init
  void initLocalNotification(
      GlobalKey<NavigatorState> navigatorKey, RemoteMessage message) async {
    var androidInitSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitSettings = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(
        android: androidInitSettings, iOS: iosInitSettings);
    await _flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleNotification(navigatorKey, message);
    });
  }

  //init Firebase

  void firebaseInit(GlobalKey<NavigatorState> navigatorKey) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        if (kDebugMode) {
          debugPrint('Got a message whilst in the foreground!');
          debugPrint('Message title: ${notification.title}');
          debugPrint('Message body: ${notification.body}');
        }
        if (Platform.isIOS) {
          iosForegroundNotification();
        }
        if (Platform.isAndroid) {
          initLocalNotification(navigatorKey, message);
          // handleNotification(context, message);
          showNotification(message);
        }
      }
    });
  }

  //show notifications
  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification == null || message.notification!.android == null) {
      return;
    }
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.high,
        showBadge: true,
        playSound: true);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: channel.sound,
    );
    //IOS setting
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: "my_data");
    });
  }

  //background and terminated app
  Future<void> setupInteractiveNotification(
      GlobalKey<NavigatorState> navigatorKey) async {
    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotification(navigatorKey, message);
    });
    //terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null && message.data.isNotEmpty) {
        handleNotification(navigatorKey, message);
      }
    });
  }
  //handler

  Future<void> handleNotification(
      GlobalKey<NavigatorState> navigatorKey, RemoteMessage message) async {
    try {
      // debugPrint("Navigating: ${message.data}");
      // navigatorKey.currentState
      //     ?.pushNamed(RouteConstants.requestHistoryScreenRoute);
      // Ensure the 'status' key exists and its value is 'Pending'
      if (message.data['status'] == 'Pending') {
        // Check if a specific screen is mentioned (optional based on your logic)
        if (message.data.containsKey('orderId')) {
          navigatorKey.currentState
              ?.pushNamed(RouteConstants.requestHistoryScreenRoute);
        } else if (message.data.containsKey('workOrderId')) {
          navigatorKey.currentState
              ?.pushNamed(RouteConstants.merchantViewAllOrdersRoute);
          debugPrint("OrderId key is missing in notification data.");
        }
      } else {
        debugPrint("Status is not 'Pending' or missing in notification data.");
      }
    } catch (e, stacktrace) {
      debugPrint("Error handling notification: $e");
      debugPrint(stacktrace.toString());
    }
    // debugPrint("navigating: ${message.data}");
    // if (message.data['status'] == 'Pending') {
    //   debugPrint(message.data['screen']);
    //   debugPrint(message.data['offer'].toString());

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
    //   );
    // }
  }

  //ios foreground notification
  Future iosForegroundNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
