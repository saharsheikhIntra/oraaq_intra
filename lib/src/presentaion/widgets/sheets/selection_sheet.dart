part of 'package:oraaq/src/presentaion/widgets/sheets/sheet_component.dart';

class _SelectionSheet extends StatelessWidget {
  final List<String> options;
  final String title;
  final String? selected;
  const _SelectionSheet({
    required this.options,
    required this.title,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          title,
          style: TextStyleTheme.headlineSmall,
        ).paddingOnly(left: 24, bottom: 32),
        ...options.map((option) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: SelectionButton(
                height: 56,
                title: option,
                backgroundColor: ColorTheme.neutral1,
                isSelected: option == selected,
                onPressed: () => context.pop(result: option),
              ));
        }),
        //.toList(),
      ],
    );
  }
}
