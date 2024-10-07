import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

enum SettingTileVariant { normal, external, warning }

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final SettingTileVariant variant;
  final VoidCallback onTap;
  const SettingTile({
    super.key,
    required this.title,
    required this.icon,
    required this.variant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: 12.borderRadius,
        child: Ink(
            decoration: BoxDecoration(
              color: ColorTheme.white,
              border: Border.all(color: ColorTheme.neutral1, width: 2.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                icon,
                color: _getIconcolor(),
              ),
              title: Text(
                title,
                style:
                    TextStyleTheme.labelLarge.copyWith(color: _getTextcolor()),
              ),
              trailing: _getTrailingIcon(),
              contentPadding: 16.horizontalPadding,
            )));
  }

  Color _getTextcolor() {
    return variant == SettingTileVariant.warning
        ? ColorTheme.error
        : ColorTheme.primaryText;
  }

  Color _getIconcolor() {
    return variant == SettingTileVariant.warning
        ? ColorTheme.error
        : ColorTheme.neutral3;
  }

  Widget? _getTrailingIcon() {
    return switch (variant) {
      SettingTileVariant.normal => const Icon(
          Symbols.arrow_forward_ios_rounded,
          color: ColorTheme.neutral3,
          size: 16,
        ),
      SettingTileVariant.external => const Icon(
          Symbols.north_east_rounded,
          color: ColorTheme.neutral3,
          size: 16,
        ),
      SettingTileVariant.warning => null
    };
  }
}
