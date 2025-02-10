part of 'package:oraaq/src/presentaion/widgets/sheets/sheet_component.dart';

class _WarningSheet extends StatelessWidget {
  final String title;
  final String message;
  final String ctaText;
  final String cancelText;
  final VoidCallback onCtaTap;
  final VoidCallback onCancelTap;

  const _WarningSheet({
    required this.title,
    required this.message,
    required this.ctaText,
    required this.cancelText,
    required this.onCtaTap,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleTheme.headlineSmall,
        ),
        24.verticalSpace,
        Text(message,
            style:
                TextStyleTheme.bodyLarge.copyWith(color: ColorTheme.neutral3)),
        40.verticalSpace,
        CustomButton(
          width: double.infinity,
          onPressed: onCtaTap,
          text: ctaText,
          size: CustomButtonSize.large,
          type: CustomButtonType.danger,
        ),
        16.verticalSpace,
        CustomButton(
          width: double.infinity,
          onPressed: onCancelTap,
          text: cancelText,
          size: CustomButtonSize.large,
          type: CustomButtonType.primary,
        ),
      ],
    ).paddingOnly(top: 24, left: 24, right: 24, bottom: 24);
  }
}
