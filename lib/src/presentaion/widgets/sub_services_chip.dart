import 'package:flutter/material.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

enum SubServicesChipVariant {
  forRequestCard,
  forSheets,
  forQuestionnaire,
  forOfferReceivedScreen,
  forCompletedJobSheet,
}

class SubServicesChip extends StatelessWidget {
  final String service;
  final SubServicesChipVariant variant;
  const SubServicesChip({
    super.key,
    required this.service,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    double hPadding = variant == SubServicesChipVariant.forRequestCard ? 6 :
    variant == SubServicesChipVariant.forOfferReceivedScreen ? 10 : 8;
    return Container(
        decoration: BoxDecoration(
            borderRadius: 4.borderRadius,
            color: switch (variant) {
              SubServicesChipVariant.forRequestCard => ColorTheme.neutral1,
              SubServicesChipVariant.forOfferReceivedScreen => ColorTheme.white,
              SubServicesChipVariant.forCompletedJobSheet => ColorTheme.white,
              _ => ColorTheme.primary.shade50,
            },
          border: switch (variant) {
          SubServicesChipVariant.forOfferReceivedScreen => Border.all(color: ColorTheme.neutral1, width: 1,),
          _ => null,
          }
            ),
        padding: EdgeInsets.fromLTRB(hPadding, 3, hPadding, 4),
        child: Text(
          service,
          textAlign: TextAlign.center,
          style: switch (variant) {
            SubServicesChipVariant.forQuestionnaire => TextStyleTheme.labelSmall.copyWith(color: ColorTheme.primary.shade500),
            SubServicesChipVariant.forRequestCard => TextStyleTheme.labelSmall.copyWith(color: ColorTheme.secondaryText),
            SubServicesChipVariant.forSheets => TextStyleTheme.labelLarge.copyWith(color: ColorTheme.secondaryText),
            SubServicesChipVariant.forOfferReceivedScreen => TextStyleTheme.labelLarge.copyWith(color: ColorTheme.neutral3),
            SubServicesChipVariant.forCompletedJobSheet => TextStyleTheme.labelLarge.copyWith(color: ColorTheme.secondaryText, fontSize: 14, fontWeight: FontWeight.w500),
          },
        ));
  }
}
