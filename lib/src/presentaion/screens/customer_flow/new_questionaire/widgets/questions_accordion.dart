// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:oraaq/src/config/themes/color_theme.dart';
// import 'package:oraaq/src/config/themes/text_style_theme.dart';
// import 'package:oraaq/src/core/extensions/num_extension.dart';

// import '../../../../../domain/entities/service_entity.dart';

// class QuestionsAccordion2 extends StatefulWidget {
//   final ServiceEntity service;

//   final Function(ServiceEntity selected) onChanged;
//   const QuestionsAccordion2({
//     super.key,
//     required this.service,
//     required this.onChanged,
//   });

//   @override
//   State<QuestionsAccordion2> createState() => _QuestionsAccordion2State();
// }

// class _QuestionsAccordion2State extends State<QuestionsAccordion2> {
//   final List<ServiceEntity> _options = [];
//   final List<ServiceEntity> _selectedServices = [];

//   @override
//   void initState() {
//     super.initState();
//     for (var curr in widget.service.services) {
//       _options.add(curr);
//       // if (curr.services.isNotEmpty) _options.addAll(curr.services);
//     }
//   }

//   void _toggleOption(ServiceEntity curr) {
//     log(curr.shortTitle);
//     _selectedServices.contains(curr) ? _selectedServices.remove(curr) : _selectedServices.add(curr);
//     widget.onChanged(curr);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//       decoration: BoxDecoration(
//           borderRadius: 12.borderRadius,
//           color: ColorTheme.neutral1,
//           border: Border.all(
//             width: 2,
//             color: ColorTheme.neutral1,
//             strokeAlign: BorderSide.strokeAlignCenter,
//           )),
//       child: ClipRRect(
//         borderRadius: 12.borderRadius,
//         child: ExpansionTile(
//           shape: const Border(),
//           title: Text(
//             widget.service.shortTitle,
//             style: TextStyleTheme.titleMedium,
//           ),
//           subtitle: widget.service.prompt.isEmpty
//               ? null
//               : Text(
//                   widget.service.prompt,
//                 ),
//           collapsedBackgroundColor: ColorTheme.neutral1,
//           backgroundColor: ColorTheme.white,
//           children: [
//             Padding(
//                 padding: 8.allPadding,
//                 child: Container(
//                     decoration: BoxDecoration(
//                       color: ColorTheme.scaffold,
//                       borderRadius: 8.borderRadius,
//                     ),
//                     child: ListView.separated(
//                       shrinkWrap: true,
//                       itemCount: _options.length,
//                       physics: const NeverScrollableScrollPhysics(),
//                       separatorBuilder: (context, index) => const Divider(
//                         thickness: 1,
//                         height: 1,
//                         color: ColorTheme.neutral1,
//                       ),
//                       itemBuilder: (BuildContext context, int index) {
//                         var option = _options[index];
//                         option.isLastLeaf;
//                         return ListTile(
//                             contentPadding: EdgeInsets.fromLTRB(option.isLastLeaf ? 40 : 12, 8, 8, 8),
//                             // onTap: () => _toggleOption(option),
//                             title: Text(
//                               option.shortTitle,
//                               style: TextStyleTheme.titleSmall.copyWith(
//                                 color: ColorTheme.secondaryText,
//                                 fontWeight: option.isLastLeaf ? FontWeight.w500 : null,
//                               ),
//                             ),
//                             subtitle: Text("Rs. ${option.price}"),
//                             trailing: Checkbox(
//                               value: _selectedServices.contains(option),
//                               onChanged: (_) => _toggleOption(option),
//                             ));
//                       },
//                     ))),
//           ],
//         ),
//       ),
//     );
//   }
// }


// ---------------------------------------------------working with radio boxes------------------------------------------------

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

import '../../../../../domain/entities/service_entity.dart';

class QuestionsAccordion2 extends StatefulWidget {
  final ServiceEntity service;

  final Function(ServiceEntity selected) onChanged;
  const QuestionsAccordion2({
    super.key,
    required this.service,
    required this.onChanged,
  });

  @override
  State<QuestionsAccordion2> createState() => _QuestionsAccordion2State();
}

class _QuestionsAccordion2State extends State<QuestionsAccordion2> {
  final List<ServiceEntity> _options = [];
  final List<ServiceEntity> _selectedServices = [];
  ServiceEntity _selectedService = ServiceEntity(serviceId: 0, shortTitle: 'example007', description: '', price: 100, prompt: '', isServiceGroup: false, isLastLeaf: false, services: []);

  @override
  void initState() {
    super.initState();
    for (var curr in widget.service.services) {
      _options.add(curr);
      // if (curr.services.isNotEmpty) _options.addAll(curr.services);
    }
  }

  void _toggleOption(ServiceEntity curr) {
    log(curr.shortTitle);
    _selectedServices.contains(curr) ? _selectedServices.remove(curr) : _selectedServices.add(curr);
    widget.onChanged(curr);
    setState(() {});
  }

  void _selectRadio(ServiceEntity curr) {
    if(_selectedService == curr){
      return;
    }
    //  widget.onChanged(curr);
    if(_selectedService.shortTitle == 'example007'){
      log(curr.shortTitle);
      _selectedService = curr;
      widget.onChanged(_selectedService);
      setState(() {});
    }else{
      widget.onChanged(_selectedService);
      log(curr.shortTitle);
      _selectedService = curr;
      widget.onChanged(_selectedService);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          initiallyExpanded: false,
          shape: const Border(),
          title: Text(
            widget.service.shortTitle,
            style: TextStyleTheme.titleMedium,
          ),
          subtitle: widget.service.prompt.isEmpty
              ? null
              : Text(
                  widget.service.prompt,
                ),
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
                      itemCount: _options.length,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                        height: 1,
                        color: ColorTheme.neutral1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        var option = _options[index];
                        // log(option.isRadio.toString());
                        option.isLastLeaf;
                        return ListTile(
                            contentPadding: EdgeInsets.fromLTRB(option.isLastLeaf ? 40 : 12, 8, 8, 8),
                            // onTap: () => _toggleOption(option),
                            title: Text(
                              option.shortTitle,
                              style: TextStyleTheme.titleSmall.copyWith(
                                color: ColorTheme.secondaryText,
                                fontWeight: option.isLastLeaf ? FontWeight.w500 : null,
                              ),
                            ),
                            subtitle: option.isLastLeaf ? Text("Rs. ${option.price}"):Text(option.prompt),
                            trailing: option.isRadio  ? Radio(
                              groupValue: _selectedService,
                              value: option,
                              onChanged: (_) => _selectRadio(option),
                            ):
                            Checkbox(
                              value: _selectedServices.contains(option),
                              onChanged: (_) => _toggleOption(option),
                            )
                            ,);
                      },
                    ))),
          ],
        ),
      ),
    );
  }
}


