// import 'dart:developer';

// import 'package:geocoding/geocoding.dart';
// import 'package:logger/logger.dart';
// import 'package:oraaq/src/imports.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/customer_edit_profile/customer_edit_profile_cubit.dart';

// class CustomerEditProfileScreen extends StatefulWidget {
//   const CustomerEditProfileScreen({super.key});

//   @override
//   State<CustomerEditProfileScreen> createState() =>
//       _CustomerEditProfileScreenState();
// }

// class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();

//   UserEntity user = getIt.get<UserEntity>();

//   LatLng? _selectedPosition;
//   final _formKey = GlobalKey<FormState>();
//   String _selectedAddress = "";

//   CustomerEditProfileCubit _cubit = getIt.get<CustomerEditProfileCubit>();

//   @override
//   void initState() {
//     emailController.text = user.email;
//     phoneNumberController.text = user.phone;
//     nameController.text = user.name;
//     _extractAddress().then((value) {
//       locationController.text = _selectedAddress;
//     });
//     log(user.id.toString());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     phoneNumberController.dispose();
//     nameController.dispose();
//     locationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorTheme.scaffold,
//       appBar: AppBar(title: const Text(StringConstants.editProfile)),
//       body: BlocProvider(
//         create: (context) => _cubit,
//         child: BlocListener<CustomerEditProfileCubit, CustomerEditProfileState>(
//           listener: (context, state) {
//             // TODO: implement listener
//             if (state is CustomerEditProfileSuccess) {
//               DialogComponent.hideLoading(context);
//               context
//                   .pushReplacementNamed(RouteConstants.customerHomeScreenRoute);
//             } else if (state is CustomerEditProfileError) {
//               DialogComponent.hideLoading(context);
//               Toast.show(
//                   variant: SnackbarVariantEnum.warning,
//                   title: state.error.code!,
//                   message: state.error.message,
//                   context: context);
//             } else if (state is CustomerEditProfileLoading) {
//               DialogComponent.showLoading(context);
//             }
//           },
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     enabled: false,
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: StringConstants.email,
//                       labelStyle: TextStyleTheme.labelLarge
//                           .copyWith(color: ColorTheme.neutral3),
//                     ),
//                   ),
//                   24.verticalSpace,
//                   TextFormField(
//                     enabled: true,
//                     controller: phoneNumberController,
//                     keyboardType: TextInputType.phone,
//                     validator: (value) =>
//                         ValidationUtils.checkPhoneNumber(value),
//                     decoration: InputDecoration(
//                       labelText: StringConstants.phone,
//                     ),
//                   ),
//                   24.verticalSpace,
//                   TextFormField(
//                       enabled: true,
//                       controller: nameController,
//                       validator: (value) =>
//                           ValidationUtils.checkEmptyField(value),
//                       keyboardType: TextInputType.name,
//                       decoration: const InputDecoration(
//                         labelText: StringConstants.yourName,
//                       )),
//                   24.verticalSpace,
//                   TextFormField(
//                       onTap: () async {
//                         // SheetComponenet.showSelectionSheet(
//                         //     context,
//                         //     title: "Select Serviced Type",
//                         //     selected: "Option 3",
//                         //     options: List.generate(3, (index) => "Option $index"),
//                         //   ) ;
//                         var result = await context
//                             .pushNamed(RouteConstants.pickMerchantLocation);
//                         if (result is LatLng) {
//                           await _extractAddress();
//                           locationController.text = _selectedAddress;
//                           // "${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}";
//                           _selectedPosition = result;
//                           log(_selectedAddress);
//                         }
//                       },
//                       readOnly: true,
//                       controller: locationController,
//                       decoration: const InputDecoration(
//                           hintText: StringConstants.yourLocation,
//                           labelText: StringConstants.yourLocation,
//                           suffixIcon: Icon(
//                             Symbols.distance_rounded,
//                             size: 24,
//                           ))),
//                   const Spacer(),
//                   CustomButton(
//                     width: double.infinity,
//                     type: CustomButtonType.primary,
//                     text: "Save",
//                     onPressed: () {
//                       // context.pushReplacementNamed(RouteConstants.customerHomeScreenRoute);
//                       if (_formKey.currentState?.validate() ?? false) {
//                         _cubit.updateCustomerProfile(
//                             email: emailController.text,
//                             name: nameController.text,
//                             phone: phoneNumberController.text,
//                             latitude: double.parse(
//                                 _selectedPosition?.latitude.toString() ??
//                                     user.latitude),
//                             longitude: double.parse(
//                                 _selectedPosition?.longitude.toString() ??
//                                     user.longitude));
//                       }
//                     },
//                   ),
//                   12.verticalSpace,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _extractAddress() async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         _selectedPosition!.latitude,
//         _selectedPosition!.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         Placemark first = placemarks.first;
//         Set<String> tempAddress = {};

//         if (first.name != null && first.name!.isNotEmpty) {
//           tempAddress.add(first.name!.trim());
//         }
//         if (first.street != null && first.street!.isNotEmpty) {
//           tempAddress.add(first.street!.trim());
//         }
//         if (first.subThoroughfare != null &&
//             first.subThoroughfare!.isNotEmpty) {
//           tempAddress.add(first.subThoroughfare!.trim());
//         }
//         if (first.thoroughfare != null && first.thoroughfare!.isNotEmpty) {
//           tempAddress.add(first.thoroughfare!.trim());
//         }
//         if (first.subLocality != null && first.subLocality!.isNotEmpty) {
//           tempAddress.add(first.subLocality!.trim());
//         }
//         if (first.locality != null && first.locality!.isNotEmpty) {
//           tempAddress.add(first.locality!.trim());
//         }
//         if (first.subAdministrativeArea != null &&
//             first.subAdministrativeArea!.isNotEmpty) {
//           tempAddress.add(first.subAdministrativeArea!.trim());
//         }
//         if (first.administrativeArea != null &&
//             first.administrativeArea!.isNotEmpty) {
//           tempAddress.add(first.administrativeArea!.trim());
//         }
//         if (first.postalCode != null && first.postalCode!.isNotEmpty) {
//           tempAddress.add(first.postalCode!.trim());
//         }
//         if (first.country != null && first.country!.isNotEmpty) {
//           tempAddress.add(first.country!.trim());
//         }

//         _selectedAddress = tempAddress.join(", ");
//       }
//     } on Exception catch (e) {
//       Logger().e(e);
//     }
//   }
// }

import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_edit_profile/customer_edit_profile_cubit.dart';

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
  final _formKey = GlobalKey<FormState>();
  String _selectedAddress = "";
  CustomerEditProfileCubit _cubit = getIt.get<CustomerEditProfileCubit>();

  @override
  void initState() {
    _extractAddress().then((value) {
      locationController.text = _selectedAddress;
      print(value);
    });
    emailController.text = user.email;
    phoneNumberController.text = user.phone;
    nameController.text = user.name;
    // locationController.text = user.longitude == "" || user.latitude == ""
    //     ? StringConstants.selectServiceLocation
    //     : "${user.latitude}, ${user.longitude}";
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
              context
                  .pushReplacementNamed(RouteConstants.customerHomeScreenRoute);
            } else if (state is CustomerEditProfileError) {
              DialogComponent.hideLoading(context);
              Toast.show(
                  variant: SnackbarVariantEnum.warning,
                  title: state.error.code!,
                  message: state.error.message,
                  context: context);
            } else if (state is CustomerEditProfileLoading) {
              DialogComponent.showLoading(context);
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    enabled: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: StringConstants.email,
                      labelStyle: TextStyleTheme.labelLarge
                          .copyWith(color: ColorTheme.neutral3),
                    ),
                  ),
                  24.verticalSpace,
                  TextFormField(
                    enabled: true,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        ValidationUtils.checkPhoneNumber(value),
                    decoration: InputDecoration(
                      labelText: StringConstants.phone,
                    ),
                  ),
                  24.verticalSpace,
                  TextFormField(
                      enabled: true,
                      controller: nameController,
                      validator: (value) =>
                          ValidationUtils.checkEmptyField(value),
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
                          _extractAddress().then((value) {
                            locationController.text = _selectedAddress;
                            _selectedPosition = result;
                            log(result.toString());
                          });
                          
                          // locationController.text =

                          //     // "${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}";
                          //     _selectedAddress;
                        }
                      },
                      readOnly: true,
                      controller: locationController,
                      decoration: const InputDecoration(
                          hintText: StringConstants.yourLocation,
                          labelText: StringConstants.yourLocation,
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
                      if (_formKey.currentState?.validate() ?? false) {
                        log(_selectedPosition.toString());
                        _cubit.updateCustomerProfile(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneNumberController.text,
                            latitude: double.parse(
                                _selectedPosition?.latitude.toString() ??
                                    user.latitude),
                            longitude: double.parse(
                                _selectedPosition?.longitude.toString() ??
                                    user.longitude));
                      }
                    },
                  ),
                  12.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _extractAddress() async {
    try {
      double latitude =
          _selectedPosition?.latitude ?? double.parse(user.latitude);
      double longitude =
          _selectedPosition?.longitude ?? double.parse(user.longitude);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark first = placemarks.first;
        Set<String> tempAddress = {};

  
        // }
        if (first.subLocality != null && first.subLocality!.isNotEmpty) {
          tempAddress.add(first.subLocality!.trim());
        }
        if (first.locality != null && first.locality!.isNotEmpty) {
          tempAddress.add(first.locality!.trim());
        }
        if (first.subAdministrativeArea != null &&
            first.subAdministrativeArea!.isNotEmpty) {
          tempAddress.add(first.subAdministrativeArea!.trim());
        }
        if (first.administrativeArea != null &&
            first.administrativeArea!.isNotEmpty) {
          tempAddress.add(first.administrativeArea!.trim());
        }
        if (first.postalCode != null && first.postalCode!.isNotEmpty) {
          tempAddress.add(first.postalCode!.trim());
        }
        if (first.country != null && first.country!.isNotEmpty) {
          tempAddress.add(first.country!.trim());
        }

        _selectedAddress = tempAddress.join(", ");
        print(_selectedAddress);
      }
    } on Exception catch (e) {
      Logger().e(e);
    }
  }
}
