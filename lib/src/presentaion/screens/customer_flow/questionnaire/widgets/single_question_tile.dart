import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

class SingleQuestionTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function(bool) onChanged;

  const SingleQuestionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  State<SingleQuestionTile> createState() => _SingleQuestionTileState();
}

class _SingleQuestionTileState extends State<SingleQuestionTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() => _isSelected = !_isSelected);
          widget.onChanged(_isSelected);
        },
        child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
            decoration: BoxDecoration(
                color: ColorTheme.neutral1,
                borderRadius: 12.borderRadius,
                border: Border.all(
                  width: 2,
                  color: ColorTheme.neutral1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                )),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyleTheme.titleMedium,
                    ),
                    if (widget.subtitle.isNotEmpty)
                      Text(
                        widget.subtitle,
                        style: TextStyleTheme.bodyMedium,
                      ),
                  ],
                )),
                Checkbox(
                  value: _isSelected,
                  onChanged: (_) {
                    setState(() => _isSelected = !_isSelected);
                    widget.onChanged(_isSelected);
                  },
                ),
              ],
            )));
  }
}
