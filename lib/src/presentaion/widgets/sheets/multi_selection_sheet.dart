part of 'package:oraaq/src/presentaion/widgets/sheets/sheet_component.dart';

class _MultiSelectionSheet extends StatefulWidget {
  final List<String> options;
  final String title;
  final List<String> selectedOptions;
  const _MultiSelectionSheet({
    required this.options,
    required this.title,
    required this.selectedOptions,
  });

  @override
  State<_MultiSelectionSheet> createState() => _MultiSelectionSheetState();
}

class _MultiSelectionSheetState extends State<_MultiSelectionSheet> {
  List<String> selection = [];

  @override
  void initState() {
    // if "widget.selectedOptions" is not empty than add it to selection
    super.initState();
    selection = List.from(widget.selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI(context);
    // return widget.options.length < 6
    //     ? _buildUI(context)
    //     : Expanded(
    //         child: _buildUI(context),
    //       );
  }

  Column _buildUI(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyleTheme.headlineSmall
              .copyWith(color: ColorTheme.secondaryText),
        ),
        Flexible(
            child: Scrollbar(
                thumbVisibility: true,
                radius: const Radius.circular(4),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.options.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    separatorBuilder: (context, index) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      final option = widget.options[index];
                      final isSelected = selection.contains(option);
                      return SelectionButton(
                          title: option,
                          height: 56,
                          backgroundColor: ColorTheme.neutral1,
                          isSelected: isSelected,
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                selection.remove(option);
                              } else {
                                selection.add(option);
                              }
                            });
                          });
                    }))),
        CustomButton(
          width: double.infinity,
          type: CustomButtonType.primary,
          size: CustomButtonSize.large,
          text: 'Save',
          onPressed: () => context.pop(result: selection),
        ).wrapInPadding(24.horizontalPadding),
        24.verticalSpace,
      ],
    );
  }
}
