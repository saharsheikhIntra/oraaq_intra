import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/themes/color_theme.dart';
import '../../../../config/themes/text_style_theme.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/sheets/sheet_component.dart';

class CustomerEditProfileScreen extends StatefulWidget {
  const CustomerEditProfileScreen({super.key});

  @override
  State<CustomerEditProfileScreen> createState() => _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.scaffold,
      appBar: AppBar(title: const Text(StringConstants.editProfile)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              enabled: false,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: StringConstants.email,
                labelStyle: TextStyleTheme.labelMedium.copyWith(color: ColorTheme.neutral3),
              ),
            ),
            24.verticalSpace,
            TextFormField(
              enabled: false,
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: StringConstants.phone,
                labelStyle: TextStyleTheme.labelMedium.copyWith(color: ColorTheme.neutral3),
              ),
            ),
            24.verticalSpace,
            TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: StringConstants.yourName,
                )),
            24.verticalSpace,
            TextFormField(
                onTap: () => SheetComponenet.showSelectionSheet(
                      context,
                      title: "Select Serviced Type",
                      selected: "Option 3",
                      options: List.generate(3, (index) => "Option $index"),
                    ),
                readOnly: true,
                controller: locationController,
                decoration: const InputDecoration(
                    hintText: StringConstants.yourLocation,
                    suffixIcon: Icon(
                      Symbols.distance_rounded,
                      size: 24,
                    ))),
            const Spacer(),
            CustomButton(
              width: double.infinity,
              type: CustomButtonType.primary,
              text: "Save",
              onPressed: () {},
            ),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }
}
