import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

class CheckBoxAccordion extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<String> options;
  final List<String> alreadySelected;
  final Function(List<String> selected) onChanged;
  const CheckBoxAccordion({
    super.key,
    required this.title,
    required this.alreadySelected,
    required this.onChanged,
    required this.options,
    required this.subtitle,
  });

  @override
  State<CheckBoxAccordion> createState() => _CheckBoxAccordionState();
}

class _CheckBoxAccordionState extends State<CheckBoxAccordion> {
  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    selectedOptions.addAll(widget.alreadySelected);
  }

  void _toggleOption(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
    widget.onChanged(selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleOption(widget.title),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        decoration: BoxDecoration(
            borderRadius: 12.borderRadius,
            color: ColorTheme.neutral1,
            border: Border.all(
              width: 2,
              color: ColorTheme.neutral1,
              strokeAlign: BorderSide.strokeAlignCenter,
            )),
        child: ClipRRect(
          borderRadius: 12.borderRadius,
          child: ExpansionTile(
            shape: const Border(),
            title: Text(
              widget.title,
              style: TextStyleTheme.titleMedium,
            ),
            subtitle: widget.subtitle.isEmpty ? null : Text(widget.subtitle),
            collapsedBackgroundColor: ColorTheme.neutral1,
            backgroundColor: ColorTheme.white,
            children: [
              Padding(
                  padding: 8.allPadding,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ColorTheme.scaffold,
                        borderRadius: 8.borderRadius,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: widget.options.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(thickness: 1, height: 1, color: ColorTheme.neutral1),
                        itemBuilder: (BuildContext context, int index) {
                          var option = widget.options[index];
                          return ListTile(
                              contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                              onTap: () => _toggleOption(option),
                              title: Text(
                                option,
                                style: TextStyleTheme.titleSmall.copyWith(color: ColorTheme.secondaryText),
                              ),
                              trailing: Checkbox(
                                value: selectedOptions.contains(option),
                                onChanged: (_) => _toggleOption(option),
                              ));
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
