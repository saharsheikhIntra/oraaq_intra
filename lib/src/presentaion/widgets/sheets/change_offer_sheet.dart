import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import '../../../config/themes/text_style_theme.dart';
import '../custom_button.dart';

enum ChangeOfferSheetVariant {
  price,
  distance,
}

class ChangeOfferSheet extends StatefulWidget {
  final int defaultValue;
  final ChangeOfferSheetVariant variant;
  const ChangeOfferSheet({
    super.key,
    required this.defaultValue,
    required this.variant,
  });

  @override
  State<ChangeOfferSheet> createState() => _ChangeOfferSheetState();
}

class _ChangeOfferSheetState extends State<ChangeOfferSheet> {
  int _defaultValue = 0;

  @override
  void initState() {
    _defaultValue = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          Text(
            widget.variant == ChangeOfferSheetVariant.distance
                ? "Adjust Search Radius"
                : "Change Offer Amount",
            style: TextStyleTheme.headlineSmall
                .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          24.verticalSpace,
          Text(
            widget.variant == ChangeOfferSheetVariant.distance
                ? "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa explicabo."
                : "doloremque laudantium, totam rem aperiam, eaque ipsa explicabo. , totam rem aperiam,",
            style: TextStyleTheme.bodyLarge
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          32.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                type: CustomButtonType.tertiary,
                icon: Symbols.remove_rounded,
                onPressed: () {
                  _decrement();
                },
              ),
              const Spacer(),
              if (widget.variant == ChangeOfferSheetVariant.price)
                const Text(
                  "Rs ",
                  style: TextStyle(
                    color: ColorTheme.secondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                ),
              if (widget.variant == ChangeOfferSheetVariant.price)
                Text(
                  "$_defaultValue",
                  style: const TextStyle(
                    color: ColorTheme.secondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                ),
              if (widget.variant == ChangeOfferSheetVariant.distance)
                Text(
                  "$_defaultValue ",
                  style: const TextStyle(
                    color: ColorTheme.secondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                ),
              if (widget.variant == ChangeOfferSheetVariant.distance)
                const Text(
                  "Km",
                  style: TextStyle(
                    color: ColorTheme.secondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                ),
              const Spacer(),
              CustomButton(
                type: CustomButtonType.tertiary,
                icon: Symbols.add_rounded,
                onPressed: () {
                  _increment();
                },
              ),
            ],
          ),
          36.verticalSpace,
          CustomButton(
            width: double.infinity,
            type: CustomButtonType.primary,
            text: widget.variant == ChangeOfferSheetVariant.distance
                ? "Update Search Radius"
                : "Update Offer",
            onPressed: () => context.pop(),
          ),
          32.verticalSpace,
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _defaultValue++;
    });
  }

  void _decrement() {
    if (widget.defaultValue > 0) {
      setState(() {
        _defaultValue--;
      });
    }
  }
}
