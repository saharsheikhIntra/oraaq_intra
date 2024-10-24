import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_edit_profile/customer_edit_profile_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_cubit.dart';

import '../../../../config/themes/color_theme.dart';
import '../../../../config/themes/text_style_theme.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/sheets/sheet_component.dart';

class CustomerEditProfileScreen extends StatefulWidget {
  const CustomerEditProfileScreen({super.key});

  @override
  State<CustomerEditProfileScreen> createState() =>
      _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  UserEntity user = getIt.get<UserEntity>();

  LatLng? _selectedPosition;

  CustomerEditProfileCubit _cubit = getIt.get<CustomerEditProfileCubit>();

  @override
  void initState() {
    emailController.text = user.email;
    phoneNumberController.text = user.phone;
    nameController.text = user.name;
    locationController.text =
        user.longitude == "null" || user.latitude == "null"
            ? StringConstants.selectServiceLocation
            : "${user.latitude}, ${user.longitude}";
    log(user.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneNumberController.dispose();
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.scaffold,
      appBar: AppBar(title: const Text(StringConstants.editProfile)),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<CustomerEditProfileCubit, CustomerEditProfileState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is CustomerEditProfileSuccess) {
              DialogComponent.hideLoading(context);
              context.pushReplacementNamed(RouteConstants.customerHomeScreenRoute);
            }else if(state is CustomerEditProfileError){
              DialogComponent.hideLoading(context);
              Toast.show(variant: SnackbarVariantEnum.warning,title: state.error.code! , message: state.error.message, context: context);
            }else if(state is CustomerEditProfileLoading){
              DialogComponent.showLoading(context);
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  enabled: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: StringConstants.email,
                    labelStyle: TextStyleTheme.labelMedium
                        .copyWith(color: ColorTheme.neutral3),
                  ),
                ),
                24.verticalSpace,
                TextFormField(
                  enabled: true,
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: StringConstants.phone,
                    labelStyle: TextStyleTheme.labelMedium
                        .copyWith(color: ColorTheme.neutral3),
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
                    onTap: () async {
                      // SheetComponenet.showSelectionSheet(
                      //     context,
                      //     title: "Select Serviced Type",
                      //     selected: "Option 3",
                      //     options: List.generate(3, (index) => "Option $index"),
                      //   ) ;
                      var result = await context
                          .pushNamed(RouteConstants.pickMerchantLocation);
                      if (result is LatLng) {
                        locationController.text =
                            "${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}";
                        _selectedPosition = result;
                      }
                    },
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
                  onPressed: () {
                    // context.pushReplacementNamed(RouteConstants.customerHomeScreenRoute);
                    _cubit.updateCustomerProfile(
                        email: emailController.text,
                        name: nameController.text,
                        phone: phoneNumberController.text,
                        latitude: double.parse(_selectedPosition?.latitude.toString() ?? user.latitude),
                        longitude: double.parse(_selectedPosition?.longitude.toString() ?? user.latitude));
                  },
                ),
                12.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
