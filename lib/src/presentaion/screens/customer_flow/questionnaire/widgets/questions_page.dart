import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_accordion.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/single_question_tile.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';

class QuestionsPage extends StatefulWidget {
  final ServiceEntity service;
  final Function(List<ServiceEntity> value) onSelect;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const QuestionsPage({
    super.key,
    required this.service,
    required this.onSelect,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final ScrollController _controller = ScrollController();
  final List<ServiceEntity> _options = [];
  final List<ServiceEntity> _selected = [];

  @override
  void initState() {
    _options.addAll(widget.service.services);
    super.initState();
  }

  // new code snippet
  void _handleCheckboxChange(ServiceEntity service) {
    setState(() {
      if (_selected.contains(service)) {
        _selected.remove(service);
      } else {
        _selected.add(service);
      }
      widget.onSelect(_selected);
    });
  }

  void _clearSelections() {
    setState(() {
      _selected.clear();
      widget.onSelect(_selected);
    });
  }
  //till----------------

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                margin: const EdgeInsets.fromLTRB(6, 24, 6, 16),
                decoration: BoxDecoration(
                  color: ColorTheme.white,
                  borderRadius: 16.borderRadius,
                  border:
                      Border.all(color: ColorTheme.neutral2.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: ColorTheme.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Scrollbar(
                    controller: _controller,
                    radius: const Radius.circular(4),
                    child: ListView(
                      padding: 0.allPadding,
                      controller: _controller,
                      children: [
                        32.verticalSpace,
                        Text(widget.service.shortTitle,
                            textAlign: TextAlign.center,
                            style: TextStyleTheme.headlineSmall.copyWith(
                              fontSize: 18,
                              color: ColorTheme.secondaryText,
                            )),
                        4.verticalSpace,
                        Padding(
                            padding: 12.horizontalPadding,
                            child: Text(
                              widget.service.prompt,
                              textAlign: TextAlign.center,
                              style: TextStyleTheme.bodyMedium
                                  .copyWith(color: ColorTheme.secondaryText),
                            )),
                        40.verticalSpace,
                        ..._options.map((e) => e.services.isEmpty
                            ? SingleQuestionTile(
                                title: e.shortTitle,
                                subtitle: "Rs. ${e.price}",
                                // onChanged: (value) {
                                //   _selected.contains(e) ? _selected.remove(e) : _selected.add(e);
                                //   widget.onSelect(_selected);
                                // },
                                onChanged: (value) => _handleCheckboxChange(e),
                              )
                            : QuestionsAccordion(
                                service: e,
                                // onChanged: (value) {
                                //   _selected.contains(value) ? _selected.remove(value) : _selected.add(value);
                                //   widget.onSelect(_selected);
                                // },
                                onChanged: (value) =>
                                    _handleCheckboxChange(value),
                              )),
                      ],
                    )))),
        Padding(
            padding: 20.horizontalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  icon: Symbols.arrow_back_rounded,
                  type: CustomButtonType.tertiary,
                  onPressed: () {
                    //new code snippet
                    // _clearSelections();
                    widget.onPrevious();
                  },
                  size: CustomButtonSize.small,
                ),
                CustomButton(
                  size: CustomButtonSize.small,
                  text: StringConstants.next,
                  iconPosition: CustomButtonIconPosition.trailing,
                  icon: Symbols.arrow_forward_rounded,
                  onPressed: () {
                    // _clearSelections();
                    widget.onNext();
                  },
                ),
              ],
            )),
        16.verticalSpace,
      ],
    );
  }
}
