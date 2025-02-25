import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oraaq/src/config/themes/app_theme.dart';
import 'package:oraaq/src/core/resources/notification_service/push_notification_service.dart';

import 'config/routes/routes.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/route_constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermissions();
    notificationService.getDeviceToken();
    notificationService.firebaseInit(navigatorKey);
    notificationService.setupInteractiveNotification(navigatorKey);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => ScreenUtilInit(
            useInheritedMediaQuery: true,
            designSize: Size(constraints.maxWidth, constraints.maxHeight),
            builder: (BuildContext context, Widget? child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: AppTheme.get,
              navigatorKey: navigatorKey,
              initialRoute: RouteConstants.splashRoute,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              scrollBehavior: ScrollConfiguration.of(context)
                  .copyWith(physics: const BouncingScrollPhysics()),
            ),
          ));
}
