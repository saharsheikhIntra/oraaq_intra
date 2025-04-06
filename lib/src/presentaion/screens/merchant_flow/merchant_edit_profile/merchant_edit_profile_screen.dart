import 'package:logger/logger.dart';
import 'package:oraaq/src/core/extensions/timeofday_extensions.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_edit_profile/merchant_edit_profile_cubit.dart';
import 'package:oraaq/src/imports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final editProfileFormKey = GlobalKey<FormState>();
  final MerchantEditProfileCubit _cubit = getIt.get<MerchantEditProfileCubit>();
  final user = getIt.get<UserEntity>();
  final TextEditingController emailController =
      TextEditingController(text: getIt.get<UserEntity>().email);
  final TextEditingController phoneNumberController =
      TextEditingController(text: getIt.get<UserEntity>().phone);
  final TextEditingController nameController =
      TextEditingController(text: getIt.get<UserEntity>().name);
  final TextEditingController locationController = TextEditingController(
      text: getIt.get<UserEntity>().longitude == null
          ? StringConstants.selectServiceLocation
          : getIt.get<UserEntity>().latitude +
              getIt.get<UserEntity>().longitude);
  final TextEditingController cnicNtnController =
      TextEditingController(text: getIt.get<UserEntity>().cnicNtn);
  final TextEditingController businessController =
      TextEditingController(text: getIt.get<UserEntity>().cnicNtn);
  final TextEditingController openingTimeController =
      TextEditingController(text: getIt.get<UserEntity>().openingTime);
  final TextEditingController closingTimeController =
      TextEditingController(text: getIt.get<UserEntity>().closingTime);
  final TextEditingController serviceController = TextEditingController(
      text: getIt.get<UserEntity>().serviceType.toString());
  final TextEditingController holidayController = TextEditingController(
      // text: getIt.get<UserEntity>().holidays.toString()
      );

  final ValueNotifier<String> openingTime = ValueNotifier<String>('');
  final ValueNotifier<String> closingTime = ValueNotifier<String>('');

  LatLng? _selectedPosition;

  final List<String> days = [
    StringConstants.monday,
    StringConstants.tuesday,
    StringConstants.wednesday,
    StringConstants.thursday,
    StringConstants.friday,
    StringConstants.saturday,
    StringConstants.sunday,
  ];

  List<CategoryEntity> categories = [];
  List<String> holidays = [];
  CategoryEntity? selectedCategory;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController.text = user.email;
    phoneNumberController.text = user.phone;
    nameController.text = user.name;
    locationController.text = "${user.latitude}, ${user.longitude}";
    cnicNtnController.text = user.cnicNtn;
    businessController.text = user.bussinessName;
    openingTimeController.text = OnTimeOfDay.formatTo12Hour(user.openingTime);
    closingTimeController.text = OnTimeOfDay.formatTo12Hour(user.closingTime);
    holidayController.text = user.holidays;
    holidays = user.holidays.split(",").map((e) => e.trim()).toList();
    // debugPrint(getIt.get<UserEntity>());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<MerchantEditProfileCubit, MerchantEditProfileState>(
        listener: (context, state) {
          if (state is MerchantProfileStateSuccess) {
            DialogComponent.hideLoading(context);
            context
                .pushReplacementNamed(RouteConstants.merchantHomeScreenRoute);
            //context.pop(result: state.user);
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.success,
              title: StringConstants.successfullyUpdatedProfile,
            );
          }
          if (state is MerchantProfileStateError) {
            DialogComponent.hideLoading(context);
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.warning,
              title: state.error.message,
            );
          }
          if (state is MerchantProfileStateLoading) {
            DialogComponent.showLoading(context);
          }
          if (state is MerchantProfileStateCategoriesLoaded) {
            DialogComponent.hideLoading(context);
            categories = state.categories;
            if (user.serviceType == -1) {
              serviceController.text = StringConstants.selectServiceType;
            } else {
              serviceController.text =
                  categories.firstWhere((e) => e.id == user.serviceType).name;
            }
          }
        },
        child: Scaffold(
          backgroundColor: ColorTheme.scaffold,
          appBar: AppBar(title: const Text(StringConstants.editProfile)),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Form(
                key: editProfileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConstants.personalInfo,
                      style: TextStyleTheme.displaySmall
                          .copyWith(color: ColorTheme.neutral3),
                    ),
                    24.verticalSpace,
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: StringConstants.yourName),
                    ),
                    16.verticalSpace,
                    TextFormField(
                        // enabled: false,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: StringConstants.email,
                          labelStyle: TextStyleTheme.labelMedium
                              .copyWith(color: ColorTheme.neutral3),
                        )),
                    16.verticalSpace,
                    TextFormField(
                      // enabled: false,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          ValidationUtils.checkPhoneNumber(value),

                      decoration: InputDecoration(
                        labelText: StringConstants.phone,
                        labelStyle: TextStyleTheme.labelMedium
                            .copyWith(color: ColorTheme.neutral3),
                      ),
                    ),
                    40.verticalSpace,
                    Text(
                      StringConstants.businessInfo,
                      style: TextStyleTheme.displaySmall
                          .copyWith(color: ColorTheme.neutral3),
                    ),
                    24.verticalSpace,
                    TextFormField(
                      validator: (value) => ValidationUtils.checkCnic(value),
                      keyboardType: TextInputType.phone,
                      controller: cnicNtnController,
                      decoration: const InputDecoration(
                          labelText: StringConstants.cnicNtn),
                    ),
                    16.verticalSpace,
                    TextFormField(
                        controller: serviceController,
                        readOnly: true,
                        decoration: const InputDecoration(
                            hintText: StringConstants.selectServiceType,
                            labelText: StringConstants.serviceType,
                            suffixIcon: Icon(
                                Symbols.keyboard_arrow_down_rounded,
                                size: 24)),
                        onTap: () {
                          SheetComponenet.showSelectionSheet(
                            context,
                            title: StringConstants.selectServiceType,
                            options: categories
                                .map((category) => category.name)
                                .toList(),
                            selected: selectedCategory?.name,
                          ).then((selected) {
                            if (selected != null) {
                              serviceController.text = selected;
                              selectedCategory = categories.firstWhere(
                                  (category) => category.name == selected);
                            }
                          });
                        }),
                    16.verticalSpace,
                    TextFormField(
                      controller: businessController,
                      decoration: const InputDecoration(
                          labelText: StringConstants.businessName),
                    ),
                    16.verticalSpace,
                    TextFormField(
                        // onTap: () => SheetComponenet.showSelectionSheet(
                        //       context,
                        //       title: "Select Serviced Type",
                        //       selected: "Option 2",
                        //       options:
                        //           List.generate(3, (index) => "Option $index"),
                        //     ),
                        onTap: () async {
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
                        validator: (value) =>
                            ValidationUtils.checkEmptyField(value),
                        decoration: const InputDecoration(
                            hintText: StringConstants.selectServiceLocation,
                            labelText: StringConstants.serviceLocation,
                            suffixIcon: Icon(
                              Symbols.distance_rounded,
                              size: 24,
                            ))),
                    8.verticalSpace,
                    Text(
                      'Select an hours only. Minutes will be set to 00 automatically.',
                      style: TextStyleTheme.bodySmall
                          .copyWith(color: ColorTheme.error),
                    ),
                    8.verticalSpace,
                    TextFormField(
                        readOnly: true,
                        onTap: () => selectTime(
                              context,
                              (time12h, time24h) {
                                openingTime.value = time24h;
                                debugPrint(openingTime.value);
                                return openingTimeController.text = time12h;
                              },
                            ),
                        controller: openingTimeController,
                        validator: (value) =>
                            ValidationUtils.checkEmptyField(value),
                        decoration: const InputDecoration(
                          hintText: StringConstants.selectopeningTime,
                          labelText: StringConstants.openingTime,
                        )),
                    16.verticalSpace,
                    TextFormField(
                        readOnly: true,
                        onTap: () => selectTime(
                              context,
                              (time12h, time24h) {
                                closingTime.value = time24h;
                                debugPrint(closingTime.value);
                                return closingTimeController.text = time12h;
                              },
                            ),
                        controller: closingTimeController,
                        validator: (value) =>
                            ValidationUtils.checkEmptyField(value),
                        decoration: const InputDecoration(
                          hintText: StringConstants.selectclosingTime,
                          labelText: StringConstants.closingTime,
                        )),
                    16.verticalSpace,
                    TextFormField(
                        onTap: () async {
                          var result =
                              await SheetComponenet.showMultipleSelectionSheet(
                            context,
                            title: StringConstants.selectHolidays,
                            selectedOptions: holidays,
                            options: days,
                          );
                          if (result is List<String>) {
                            holidays = result;
                            holidayController.text = result
                                .toString()
                                .replaceFirst(',', '')
                                .replaceAll('[', '')
                                .replaceAll(']', '');
                          }
                        },
                        readOnly: true,
                        controller: holidayController,
                        decoration: const InputDecoration(
                            hintText: StringConstants.holidays,
                            suffixIcon: Icon(
                              Symbols.keyboard_arrow_down_rounded,
                              size: 24,
                            ))),
                    40.verticalSpace,
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: CustomButton(
                            width: double.infinity,
                            type: CustomButtonType.primary,
                            text: "Update Profile",
                            onPressed: () {
                              if (editProfileFormKey.currentState!.validate()) {
                                SheetComponenet.showWarningSheet(
                                  context,
                                  title: StringConstants.areYouSure,
                                  message: StringConstants
                                      .yourProfileInformationWillBeUpdated,
                                  ctaText: StringConstants.saveChanges,
                                  cancelText: StringConstants.cancel,
                                  onCancelTap: () => context.pop(),
                                  onCtaTap: () {
                                    Logger().d(
                                        "Selected Position: $_selectedPosition");
                                    _cubit.updateMerchantProfile(
                                      merchantName: nameController.text,
                                      merchantNumber:
                                          phoneNumberController.text,
                                      cnic: cnicNtnController.text,
                                      email: emailController.text,
                                      businessName: businessController.text,
                                      latitude: _selectedPosition?.latitude
                                              .toString() ??
                                          "",
                                      longitude: _selectedPosition?.longitude
                                              .toString() ??
                                          "",
                                      offDays: holidayController.text,
                                      openingTime: openingTime.value,
                                      closingTime: closingTime.value,
                                      // openingTime: openingTimeController.text,
                                      // closingTime: closingTimeController.text,
                                      serviceType: selectedCategory?.id ??
                                          user.serviceType,
                                      holidays: holidays,
                                    );
                                    context.pop();
                                  },
                                );
                              }
                            })),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
