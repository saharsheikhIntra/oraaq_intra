// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../constants/app_constants.dart';


// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin()
//         ..initialize(
//           initAndroidIosSettings(),
//           onDidReceiveNotificationResponse: (notificationResponse) async {
//             String? payload = notificationResponse.payload;
//             if (payload != null) {
//               final RemoteMessage message = RemoteMessage(
//                 data: jsonDecode(payload),
//               );

//               onNotificationTap(message: message, methodName: 'local');
//             }
//           },
//         )
//       // ..resolvePlatformSpecificImplementation<
//       //         AndroidFlutterLocalNotificationsPlugin>()!
//       //     .requestNotificationsPermission()
//       ;

//   static InitializationSettings initAndroidIosSettings() {
//     const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

//     const initializationSettingsIOS = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );

//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     return initializationSettings;
//   }

//   static Future<void> display(RemoteMessage remoteMessage) async {
//     final RemoteNotification? notification = remoteMessage.notification;
//     if (notification != null) {
//       const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         "car_request_notification_channel",
//         "car request notification channel",
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//         icon: "@mipmap/ic_launcher",
//         channelDescription: 'your channel description',
//       );
//       const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//         subtitle: AppConstants.appName,
//         threadIdentifier: 'com.google.firebase.messaging.default_notification_channel_id',
//       );
//       const platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics,
//       );

//       _flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title ?? '',
//         notification.body ?? '',
//         platformChannelSpecifics,
//         // payload: jsonEncode(remoteMessage.data),
//       );
//     }
//   }

//   static Future<void> onNotificationTap({
//     required RemoteMessage? message,
//     required String methodName,
//   }) async {
//     if (message != null) {
//       // switch (message.data['route']) {
//       //   case RouteConstant.loginRoute:
//       //     getIt<NavigationRoute>().push(context, RouteConstant.loginRoute);
//       //     break;
//       //   case RouteConstant.welcomeRoute:
//       //     getIt<NavigationRoute>().push(context, RouteConstant.welcomeRoute);
//       //     break;
//       //   case RouteConstant.bottomNavigationRoute:
//       //     getIt<NavigationRoute>()
//       //         .push(context, RouteConstant.bottomNavigationRoute);
//       //     break;
//       //   case RouteConstant.myAccountRoute:
//       //     getIt<NavigationRoute>().popAllAndPush(
//       //       context,
//       //       RouteConstant.bottomNavigationRoute,
//       //       args: BottomNavigationScreenArg(index: 3),
//       //     );
//       //     break;
//       //   case RouteConstant.notificationRoute:
//       //     getIt<NavigationRoute>()
//       //         .push(context, RouteConstant.notificationRoute);
//       //     break;
//       //   default:
//       //     getIt<NavigationRoute>()
//       //         .push(context, RouteConstant.bottomNavigationRoute);
//       // }
//     }
//   }
// }
