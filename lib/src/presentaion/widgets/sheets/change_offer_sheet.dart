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
  final onTap;
  const ChangeOfferSheet({
    super.key,
    required this.defaultValue,
    required this.variant,
    required this.onTap,
  });

  @override
  State<ChangeOfferSheet> createState() => _ChangeOfferSheetState();
}

class _ChangeOfferSheetState extends State<ChangeOfferSheet> {
  @override
  void initState() {
    // _defaultValue = widget.defaultValue;
    _value.value = widget.defaultValue;
    super.initState();
  }

  final ValueNotifier<int> _value = ValueNotifier<int>(0);

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
                ValueListenableBuilder(
                    valueListenable: _value,
                    builder: (context, value, child) {
                      return Text(
                        "${_value.value}",
                        style: const TextStyle(
                          color: ColorTheme.secondaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.0,
                        ),
                      );
                    }),
              if (widget.variant == ChangeOfferSheetVariant.distance)
                ValueListenableBuilder(
                    valueListenable: _value,
                    builder: (context, value, child) {
                      return Text(
                        "${_value.value}",
                        style: const TextStyle(
                          color: ColorTheme.secondaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.0,
                        ),
                      );
                    }),
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
            onPressed: () => widget.onTap(_value.value),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  void _increment() {
    // setState(() {

    if (widget.variant == ChangeOfferSheetVariant.price) {
      _value.value = _value.value + 100;
    } else {
      _value.value = _value.value + 5;
    }

    // });
  }

  void _decrement() {
    if (_value.value > 0) {
      if (widget.variant == ChangeOfferSheetVariant.price) {
        _value.value = _value.value - 100;
      } else {
        _value.value = _value.value - 5;
      }
    }
  }
}
