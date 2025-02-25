import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_recieved_arguments.dart';
import '../../../app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final data = jsonDecode(message.data['data']);
  if (data['screen'] == 'offer-recieved') {
    CustomerNewRequestDto recievedReq =
        CustomerNewRequestDto.fromMap(data['offer']);
    ValueNotifier<CustomerNewRequestDto> currentRequest =
        ValueNotifier(recievedReq);
    navigatorKey.currentState?.pushNamed(
        RouteConstants.offeredReceivedScreenRoute,
        arguments: OfferRecievedArguments(currentRequest));
  } else {
    log(data['screen']);
    navigatorKey.currentState
        ?.pushNamed(RouteConstants.merchantViewAllOrdersRoute);
  }
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: "This channel is used for push notifications",
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();
  getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    final notificationData = jsonDecode(message.data['data']);
    if (notificationData['screen'] == 'offer-recieved') {
      log(notificationData['screen']);
      log(notificationData['offer'].toString());
      CustomerNewRequestDto recievedReq =
          CustomerNewRequestDto.fromMap(notificationData['offer']);
      ValueNotifier<CustomerNewRequestDto> currentRequest =
          ValueNotifier(recievedReq);
      navigatorKey.currentState?.pushNamed(
          RouteConstants.offeredReceivedScreenRoute,
          arguments: OfferRecievedArguments(currentRequest));
    } else {
      log(notificationData['screen']);
      navigatorKey.currentState
          ?.pushNamed(RouteConstants.merchantViewAllOrdersRoute);
    }
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
              importance: Importance.defaultImportance,
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    final fcmToken = await getFCMToken();
    log("Token: $fcmToken");
    initPushNotifications();
    initLocalNotifications();
  }
}
