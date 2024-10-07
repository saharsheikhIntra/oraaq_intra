import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LifeCycleEventHandler extends WidgetsBindingObserver {
  final VoidCallback? resumeCallBack;
  final VoidCallback? detachedCallBack;
  final VoidCallback? inactiveCallBack;
  final VoidCallback? pausedCallBack;
  final VoidCallback? hiddenCallBack;

  LifeCycleEventHandler({
    this.resumeCallBack,
    this.detachedCallBack,
    this.inactiveCallBack,
    this.pausedCallBack,
    this.hiddenCallBack,
  });

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    Logger().i('App Life Cycle State: $state');
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) resumeCallBack!();
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallBack != null) inactiveCallBack!();
        break;
      case AppLifecycleState.paused:
        if (pausedCallBack != null) pausedCallBack!();
        break;
      case AppLifecycleState.detached:
        if (detachedCallBack != null) detachedCallBack!();
        break;
      case AppLifecycleState.hidden:
        if (hiddenCallBack != null) hiddenCallBack!();
        break;
    }
  }
}
