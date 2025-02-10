
import 'package:fluttertoast/fluttertoast.dart';

import 'package:oraaq/src/imports.dart';

enum SnackbarVariantEnum { success, warning, normal }

class Toast {
  static void show({
    required BuildContext context,
    required SnackbarVariantEnum variant,
    required String title,
    String? message,
  }) {
    final toast = FToast().init(context);
    toast.removeQueuedCustomToasts();
    toast.showToast(
        child: _ToastUI(
          context: context,
          variant: variant,
          title: title,
          message: message,
        ),
        // gravity: ToastGravity.TOP,
        toastDuration: 5.seconds);
  }
}

// PRIVATE WIDGET - CANT BE ACCESSED OUTSIDE OF THIS FILE
class _ToastUI extends StatelessWidget {
  final BuildContext context;
  final SnackbarVariantEnum variant;
  final String title;
  final String? message;
  const _ToastUI({
    required this.context,
    required this.variant,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = switch (variant) {
      SnackbarVariantEnum.normal => ColorTheme.primary,
      SnackbarVariantEnum.warning => ColorTheme.error,
      SnackbarVariantEnum.success => ColorTheme.secondary.shade600,
    };

    Color foregroundColor = switch (variant) {
      SnackbarVariantEnum.normal => ColorTheme.primary,
      SnackbarVariantEnum.warning => ColorTheme.error,
      SnackbarVariantEnum.success => ColorTheme.secondary.shade700,
    };

    return Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        // margin: 16.allPadding,
        decoration: BoxDecoration(
          color: ColorTheme.white,
          borderRadius: 8.borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            if (variant != SnackbarVariantEnum.normal)
              Padding(
                  padding: 16.endPadding,
                  child: Icon(
                    variant == SnackbarVariantEnum.warning
                        ? Symbols.brightness_alert_rounded
                        : Symbols.verified_rounded,
                    color: foregroundColor,
                    size: 40,
                  )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleTheme.titleSmall
                      .copyWith(color: foregroundColor),
                ),
                if (message != null)
                  Padding(
                      padding: 4.topPadding,
                      child: Text(
                        message!,
                        style: TextStyleTheme.bodyMedium
                            .copyWith(color: ColorTheme.primaryText),
                      )),
              ],
            ))
          ],
        ));
  }
}
