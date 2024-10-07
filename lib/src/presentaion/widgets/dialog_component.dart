import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/presentaion/widgets/loading_indicator.dart';

class DialogComponent {
  static dynamic hideLoading(BuildContext context) => context.pop();

  static showLoading(
    BuildContext context, {
    VoidCallback? onWillPop,
    bool barrierDismissible = false,
    double blurRadius = 8,
  }) {
    return showGeneralDialog(
//       Exception has occurred.
// FlutterError (setState() or markNeedsBuild() called during build.
// This Overlay widget cannot be marked as needing to build because the framework is already in the process of building widgets. A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
// The widget on which setState() or markNeedsBuild() was called was:
//   Overlay-[LabeledGlobalKey<OverlayState>#8e77a]
// The widget which was currently being built when the offending call was made was:
//   BlocBuilder<MerchantHomeScreenCubit, MerchantHomeScreenState>)
        context: context,
        barrierLabel: 'dialog',
        transitionDuration: 300.milliseconds,
        barrierDismissible: barrierDismissible,
        barrierColor: ColorTheme.white.withOpacity(0.5),
        pageBuilder: (ctx, anim1, anim2) => PopScope(
            canPop: onWillPop == null,
            onPopInvoked: (didPop) {
              if (didPop && onWillPop != null) onWillPop();
            },
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
                child: ScaleTransition(
                    scale: Tween(begin: 0.3, end: 1.0).animate(anim1),
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(anim1),
                      child: const Center(child: LoadingIndicator()),
                    )))));
  }

  static Future show(
    BuildContext context, {
    double? width,
    double? height,
    double? maxHeight,
    double margin = 0,
    Color? barrierColor,
    Color dialogColor = Colors.white,
    EdgeInsets padding = EdgeInsets.zero,
    double borderRadius = 20,
    double blurRadius = 8,
    bool barrierDismissible = true,
    VoidCallback? onWillPop,
    required Widget child,
  }) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor ?? ColorTheme.primary.shade100.withOpacity(0.5),
        barrierLabel: 'dialog',
        transitionDuration: 300.milliseconds,
        pageBuilder: (ctx, anim1, anim2) => PopScope(
            canPop: onWillPop == null,
            onPopInvoked: (didPop) {
              if (didPop && onWillPop != null) onWillPop();
            },
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
                child: SlideTransition(
                    position: Tween(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(anim1),
                    child: AlertDialog(
                        titlePadding: EdgeInsets.zero,
                        actionsPadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.all(margin),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        content: Container(
                          width: width,
                          height: height,
                          padding: padding,
                          constraints: maxHeight != null
                              ? BoxConstraints(
                                  maxHeight: maxHeight,
                                  minHeight: 100,
                                )
                              : null,
                          decoration: BoxDecoration(
                            color: dialogColor,
                            borderRadius: BorderRadius.circular(borderRadius),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 24,
                                color: ColorTheme.neutral3.withOpacity(0.2),
                              ),
                              BoxShadow(
                                blurRadius: 24,
                                spreadRadius: -12,
                                offset: const Offset(0, 12),
                                color: ColorTheme.neutral3.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: child,
                        ))))));
  }
}
