import 'package:flutter/cupertino.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_chip.dart';

enum SubServicesChipWrapViewVariant {
  forRequestCard,
  forSheets,
  forQuestionnaire,
  forOfferReceivedScreen,
  forCompletedJobSheet,
}

class SubServicesChipWrapView extends StatelessWidget {
  final List<String> servicesList;
  final SubServicesChipWrapViewVariant variant;

  const SubServicesChipWrapView({
    super.key,
    required this.servicesList,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    double spacing = switch (variant) {
      SubServicesChipWrapViewVariant.forQuestionnaire => 6,
      _ => 8,
    };

    WrapAlignment alignment = switch (variant) {
      SubServicesChipWrapViewVariant.forQuestionnaire => WrapAlignment.center,
      _ => WrapAlignment.start,
    };

    return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: alignment,
        children: List.generate(
          servicesList.length,
          (index) => SubServicesChip(
              service: servicesList[index].trim(),
              variant: switch (variant) {
                SubServicesChipWrapViewVariant.forSheets => SubServicesChipVariant.forSheets,
                SubServicesChipWrapViewVariant.forRequestCard => SubServicesChipVariant.forRequestCard,
                SubServicesChipWrapViewVariant.forQuestionnaire => SubServicesChipVariant.forQuestionnaire,
                SubServicesChipWrapViewVariant.forOfferReceivedScreen => SubServicesChipVariant.forOfferReceivedScreen,
                SubServicesChipWrapViewVariant.forCompletedJobSheet => SubServicesChipVariant.forCompletedJobSheet,
              }),
        ));
  }
}
