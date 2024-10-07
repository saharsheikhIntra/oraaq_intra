import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';
import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

class MerchantOfferCard extends StatelessWidget {
  final String userName;
  final String distance;
  final String phoneNo;
  final String email;
  final String price;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onDistanceTap;
  const MerchantOfferCard(
      {super.key,
      required this.userName,
      required this.distance,
      required this.phoneNo,
      required this.email,
      required this.price,
      required this.onAccept,
      required this.onReject,
      required this.onDistanceTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        borderRadius: 12.borderRadius,
        color: ColorTheme.white,
        border: Border.all(
          color: ColorTheme.neutral1,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(userName, style: TextStyleTheme.titleLarge)),
              Text(distance, style: TextStyleTheme.bodyLarge.copyWith(color: ColorTheme.secondaryText)),
              8.horizontalSpace,
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: onDistanceTap,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: 4.borderRadius,
                      color: ColorTheme.scaffold,
                      border: Border.all(
                        color: ColorTheme.neutral2,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Symbols.near_me_rounded,
                      color: ColorTheme.secondaryText,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          _buildInfo(Symbols.call_rounded, phoneNo),
          4.verticalSpace,
          _buildInfo(Symbols.mail_rounded, email),
          12.verticalSpace,
          Row(
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                "Rs.",
                style: TextStyleTheme.titleLarge.copyWith(
                  color: ColorTheme.secondary.shade600,
                  fontWeight: FontWeight.w700,
                  fontSize: 22.0,
                ),
              ),
              Text(
                price,
                style: TextStyleTheme.titleLarge.copyWith(
                  color: ColorTheme.secondary.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  height: 32,
                  size: CustomButtonSize.small,
                  type: CustomButtonType.tertiary,
                  text: "Reject",
                  onPressed: onReject,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: CustomButton(
                  height: 32,
                  size: CustomButtonSize.small,
                  type: CustomButtonType.primary,
                  text: "Accept",
                  onPressed: onAccept,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfo(IconData icon, String text) => Row(children: [
        Icon(
          icon,
          color: ColorTheme.secondaryText,
          size: 18.0,
        ),
        8.horizontalSpace,
        Text(text,
            style: TextStyleTheme.bodyMedium.copyWith(
              color: ColorTheme.secondaryText,
            )),
      ]);
}
