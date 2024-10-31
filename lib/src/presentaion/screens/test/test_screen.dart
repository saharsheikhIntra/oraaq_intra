import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/constants/asset_constants.dart';
import 'package:oraaq/src/core/constants/route_constants.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/enum/user_type.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/approved_request_card.dart';
import 'package:oraaq/src/presentaion/widgets/cancel_request_card.dart';
import 'package:oraaq/src/presentaion/widgets/checkbox_accordion.dart';
import 'package:oraaq/src/presentaion/widgets/completed_request_card.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';
import 'package:oraaq/src/presentaion/widgets/merchant_offer_card.dart';
import 'package:oraaq/src/presentaion/widgets/new_request_card.dart';
import 'package:oraaq/src/presentaion/widgets/ongoing_request_card.dart';
import 'package:oraaq/src/presentaion/widgets/resend_otp.dart';
import 'package:oraaq/src/presentaion/widgets/selection_button.dart';
import 'package:oraaq/src/presentaion/widgets/setting_tile.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/change_offer_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/completed_job_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/request_confirmation_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/request_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/sheet_component.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';
import 'package:oraaq/src/presentaion/widgets/toast.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  UserType _selectedUserType = UserType.merchant;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              title: const Text("Test Screen"),
              bottom: TabBar(
                indicatorPadding: 16.horizontalPadding,
                splashBorderRadius: 12.topBorderRadius,
                tabs: const [
                  Tab(text: "On Going", icon: Icon(Symbols.award_star_rounded)),
                  Tab(text: "Completed", icon: Icon(Symbols.beenhere_rounded)),
                  Tab(
                      text: "Cancelled",
                      icon: Icon(Symbols.disabled_by_default_rounded)),
                ],
              )),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Scrollbar(
                thumbVisibility: true,
                radius: const Radius.circular(4),
                child: ListView(
                  padding: 24.allPadding,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white,
                          Colors.white,
                          Colors.white.withOpacity(0),
                        ],
                      )),
                      child: Hero(
                          tag: "logo",
                          child: Image.asset(
                            AssetConstants.logo,
                            fit: BoxFit.contain,
                            height: 64,
                          )),
                    ),
                    // ElevatedButton(
                    //   onPressed: () => selectTime(context),
                    //   child: Text("Select Time"),
                    // ),

                    _label("APPROVED REQUEST CARDS"),
                    const ApprovedRequestCard(
                      userName: "ALI",
                      distance: "9 km",
                      date: "3rd March",
                      time: "3:30 pm",
                      price: "15,000",
                      variant: ApprovedRequestCardVariant.normal,
                    ),
                    20.verticalSpace,
                    const ApprovedRequestCard(
                      userName: "ALI",
                      distance: "9 km",
                      date: "3rd March",
                      time: "3:30 pm",
                      price: "15,000",
                      variant: ApprovedRequestCardVariant.urgent,
                    ),
                    _label("NEW REQUEST CARDS"),
                    const NewRequestCard(
                      buttonText: "Already Applied",
                      userName: "ALI",
                      distance: "45 km",
                      date: "4th March",
                      time: "3:30pm",
                      price: "12000",
                      servicesList: [
                        "Hair cut",
                        "Hair",
                        "Hair",
                        "Hair",
                        "Hair extension"
                      ],
                      variant: NewRequestCardVariant.alreadyApplied,
                    ),
                    20.verticalSpace,
                    const NewRequestCard(
                      buttonText: "Already Applied",
                      userName: "ALI",
                      distance: "45 km",
                      date: "4th March",
                      time: "3:30pm",
                      price: "12000",
                      servicesList: [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair extension",
                        "Hair extension"
                      ],
                      variant: NewRequestCardVariant.newRequest,
                    ),
                    _label("ONGOING REQUEST CARDS"),
                    OnGoingRequestCard(
                      userName: "JOHN",
                      duration: "4hr 30 mints",
                      date: "21st May",
                      time: "6:00 am",
                      price: "10,000",
                      servicesList: const [
                        "Hair cut",
                        "Hair extension",
                        "Hair extension"
                      ],
                      variant: OngoingRequestCardVariant.waiting,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    OnGoingRequestCard(
                      userName: "JOHN",
                      duration: "4hr 30 mints",
                      date: "21st May",
                      time: "6:00 am",
                      price: "10,000",
                      servicesList: const [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair extension"
                      ],
                      variant: OngoingRequestCardVariant.offerAccepted,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    OnGoingRequestCard(
                      userName: "JOHN",
                      duration: "4hr 30 mints",
                      date: "21st May",
                      time: "6:00 am",
                      profileName: "Zain Hashim",
                      price: "10,000",
                      servicesList: const [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair extension"
                      ],
                      variant: OngoingRequestCardVariant.offerReceived,
                      onTap: () {},
                    ),
                    _label("CANCELLED REQUEST CARDS"),
                    CancelRequestCard(
                      userName: "AC REPAIRED",
                      duration: "4hr 30 mints",
                      date: "21st May",
                      time: "6:00 am",
                      price: "10,000",
                      servicesList: const [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair extension"
                      ],
                      onTap: () {},
                    ),
                    _label("COMPLETED REQUEST CARDS"),
                    CompletedRequestCard(
                      userName: "ALI",
                      date: "4th March",
                      ratings: "4 / 5",
                      price: "12000",
                      duration: '4 hr 40 mints',
                      rating: 3,
                      variant: CompletedRequestCardVariant.customer,
                      onTap: () {},
                      servicesList: const [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair extension"
                      ],
                    ),
                    _label("COMPLETED REQUEST CARDS"),
                    CompletedRequestCard(
                      userName: "ALI",
                      date: "4th March",
                      ratings: "4 / 5",
                      price: "12000",
                      servicesList: const [
                        "Hair cut",
                        "Hair",
                        "Hair",
                        "Hair",
                        "Hair extension"
                      ],
                      duration: '4 hr 40 mints',
                      rating: 2,
                      variant: CompletedRequestCardVariant.merchant,
                      onTap: () {},
                    ),
                    _label("MERCHANT OFFER CARD"),
                    MerchantOfferCard(
                      userName: "John Doe",
                      distance: "9 km away",
                      phoneNo: "0322 2345673",
                      email: "ambar.doe@mail.com",
                      price: "15,000",
                      onAccept: () {},
                      onReject: () {},
                      onDistanceTap: () {},
                    ),
                    _label("SUB-SERVICES FOR QUESTIONNAIRE"),
                    const SubServicesChipWrapView(
                      servicesList: [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair cut",
                        "Hair cut",
                        "Hair",
                        "Hair extension"
                      ],
                      variant: SubServicesChipWrapViewVariant.forQuestionnaire,
                    ),
                    _label("SUB-SERVICES FOR REQUEST CARD"),
                    const SubServicesChipWrapView(
                      servicesList: [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair cut",
                        "Hair cut",
                        "Hair",
                        "Hair extension"
                      ],
                      variant: SubServicesChipWrapViewVariant.forRequestCard,
                    ),
                    _label("SUB-SERVICES FOR SHEETS"),
                    const SubServicesChipWrapView(
                      servicesList: [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair cut",
                        "Hair cut",
                        "Hair",
                        "Hair extension"
                      ],
                      variant: SubServicesChipWrapViewVariant.forSheets,
                    ),
                    _label("SUB-SERVICES FOR OFFER RECEIVED SCREEN"),
                    const SubServicesChipWrapView(
                      servicesList: [
                        "Hair cut",
                        "Hair",
                        "Hair extension",
                        "Hair cut",
                        "Hair cut",
                        "Hair",
                        "Hair extension"
                      ],
                      variant:
                          SubServicesChipWrapViewVariant.forOfferReceivedScreen,
                    ),
                    _label("CUSTOM BUTTON"),
                    _customButtons(),
                    _label("TOASTS"),
                    OutlinedButton(
                        child: const Text("Show Normal Toast"),
                        onPressed: () => Toast.show(
                              context: context,
                              variant: SnackbarVariantEnum.normal,
                              title: "Lorem Ipsum",
                            )),
                    OutlinedButton(
                        child: const Text("Show Warning Toast"),
                        onPressed: () => Toast.show(
                              context: context,
                              variant: SnackbarVariantEnum.warning,
                              title: "Lorem Ipsum",
                              message: StringConstants.welcomeMessage,
                            )),
                    OutlinedButton(
                        child: const Text("Show Success Toast"),
                        onPressed: () => Toast.show(
                              context: context,
                              variant: SnackbarVariantEnum.success,
                              title: "Lorem Ipsum",
                              message: StringConstants.welcomeMessage,
                            )),
                    _label("OTP Field"),
                    // OtpWidget(
                    //   onOtpVerified:(value) => log(value.toString()
                    // )),
                    _label("RESEND OTP"),
                    Center(
                        child: ResendOtpWidget(
                            duration: 20.seconds,
                            onResend: () => log("Resend"))),
                    _label("CHECKBOX ACCORDION"),
                    CheckBoxAccordion(
                        title: 'Hair Services',
                        subtitle: 'Hair Services',
                        alreadySelected: const ["Hair Treatment"],
                        onChanged: (List<String> selected) {
                          Logger().d(selected);
                        },
                        options: const [
                          "Hair Cutting",
                          "Hair Treatment",
                          "Hair Coloring",
                          "Hair Extension",
                          "Hair Trimming",
                        ]),
                    _label("SHEETS"),
                    ...sheets(context),
                    _label("SELECTION BUTTON"),
                    ...UserType.values.map((e) => SelectionButton(
                          height: 64,
                          title: e.title,
                          icon: e.icon,
                          isSelected: _selectedUserType == e,
                          onPressed: () =>
                              setState(() => _selectedUserType = e),
                        )),
                    // .toList(),
                    _label("SETTING TILE"),
                    SettingTile(
                      title: 'Jobs History',
                      icon: Symbols.history_rounded,
                      variant: SettingTileVariant.external,
                      onTap: () {},
                    ),
                    8.verticalSpace,
                    SettingTile(
                      title: 'Change Password',
                      icon: Symbols.lock_outline_rounded,
                      variant: SettingTileVariant.normal,
                      onTap: () {},
                    ),
                    8.verticalSpace,
                    SettingTile(
                      title: 'Pause Service',
                      icon: Symbols.pause_circle_rounded,
                      variant: SettingTileVariant.warning,
                      onTap: () {},
                    ),
                    8.verticalSpace,
                    SettingTile(
                      title: 'Logout',
                      icon: Symbols.logout_rounded,
                      variant: SettingTileVariant.warning,
                      onTap: () {},
                    ),
                    _label("SCREENS"),
                    OutlinedButton(
                        child: const Text("Pick Location"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.pickLocationRoute)),
                    OutlinedButton(
                        child: const Text("Merchant Edit Profile"),
                        onPressed: () => context.pushNamed(
                            RouteConstants.merchantEditProfileRoute)),
                    OutlinedButton(
                        child: const Text("Merchant Profile"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.merchantProfileRoute)),
                    OutlinedButton(
                        child: const Text("Customer Profile"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.customerProfileRoute)),
                    OutlinedButton(
                        child: const Text("Customer Edit Profile"),
                        onPressed: () => context.pushNamed(
                            RouteConstants.customerEditProfileRoute)),
                    OutlinedButton(
                        child: const Text("Change Password"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.changePasswordRoute)),
                    OutlinedButton(
                        child: const Text("Welcome Screen"),
                        onPressed: () =>
                            context.pushNamed(RouteConstants.welcomeRoute)),
                    OutlinedButton(
                        child: const Text("Questionnaire Screen"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.questionnaireRoute)),
                    OutlinedButton(
                        child: const Text("Go To Pick Location Screen"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.pickLocationRoute)),
                    OutlinedButton(
                        child: const Text("Customer Home Screen"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.customerHomeScreenRoute)),
                    OutlinedButton(
                        child: const Text("Offer Received Screen"),
                        onPressed: () => context.pushNamed(
                            RouteConstants.offeredReceivedScreenRoute)),
                    OutlinedButton(
                        child: const Text("Request History Screen"),
                        onPressed: () => context.pushNamed(
                            RouteConstants.requestHistoryScreenRoute)),
                    OutlinedButton(
                        child: const Text("Merchant Home Screen"),
                        onPressed: () => context
                            .pushNamed(RouteConstants.merchantHomeScreenRoute)),
                    24.verticalSpace,
                  ],
                ),
              ),
              const Center(child: Text("Completed")),
              const Center(child: Text("Cancelled")),
            ],
          )),
    );
  }

  List<Widget> sheets(BuildContext context) {
    return [
      OutlinedButton(
          child: const Text("Show Sheet"),
          onPressed: () => SheetComponenet.show(
                context,
                child: const Placeholder(strokeWidth: 0.25),
              )),
      OutlinedButton(
          child: const Text("Show Warning Sheet"),
          onPressed: () => SheetComponenet.showWarningSheet(
                context,
                title: "Warning Title",
                message:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                ctaText: "CTA",
                cancelText: "Cancel",
                onCtaTap: () {},
                onCancelTap: () => context.pop(),
              )),
      OutlinedButton(
          child: const Text("Show Selection Sheet"),
          onPressed: () => SheetComponenet.showSelectionSheet(
                context,
                title: "Select An Option",
                selected: "Option 3",
                options: List.generate(5, (index) => "Option $index"),
              )),
      OutlinedButton(
          child: const Text("Show Multi Selection Sheet"),
          onPressed: () => SheetComponenet.showMultipleSelectionSheet(
                context,
                title: "Select An Option",
                options: List.generate(12, (index) => "Option $index"),
                selectedOptions:
                    List.generate(2, (index) => "Option ${index * 2}"),
              )),
      OutlinedButton(
          child: const Text("Change Offer Amount"),
          onPressed: () => SheetComponenet.show(context,
              child: ChangeOfferSheet(
                defaultValue: 15000,
                variant: ChangeOfferSheetVariant.price,
                onTap: () {},
              ))),
      OutlinedButton(
          child: const Text("Adjust Search Radius"),
          onPressed: () => SheetComponenet.show(context,
              child: ChangeOfferSheet(
                defaultValue: 50,
                variant: ChangeOfferSheetVariant.distance,
                onTap: () {},
              ))),
      OutlinedButton(
          child: const Text("Request Sheet"),
          onPressed: () => SheetComponenet.show(
                context,
                isScrollControlled: true,
                child: RequestSheet(onCancel: () {}),
              )),
      OutlinedButton(
          child: const Text("Request Confirmation Sheet"),
          onPressed: () => SheetComponenet.show(
                context,
                isScrollControlled: true,
<<<<<<< HEAD
                child: RequestConfirmationSheet(onConfirm: (){}, address: '', datetime: '', serviceType: '', offeredAmount: '', services: [],),
=======
                child: RequestConfirmationSheet(
                  onConfirm: () {},
                ),
>>>>>>> eb7bace4cca3d6b249d6b9e8116af7f9f3f06a7b
              )),
      OutlinedButton(
          child: const Text("Completed job sheet - Merchant"),
          onPressed: () => SheetComponenet.show(context,
              isScrollControlled: true,
              child: const CompletedJobSheet(
                rating: 3,
                variant: CompletedJobSheetVariant.merchant,
              ))),
      OutlinedButton(
          child: const Text("Completed job sheet - Customer"),
          onPressed: () => SheetComponenet.show(context,
              isScrollControlled: true,
              child: const CompletedJobSheet(
                rating: 0,
                variant: CompletedJobSheetVariant.customer,
              ))),
    ];
  }

  Wrap _customButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        CustomButton(
          text: "Title",
        ),
        CustomButton(
          text: "Title",
          onPressed: () {},
        ),
        CustomButton(
          icon: Symbols.verified_rounded,
        ),
        CustomButton(
          icon: Symbols.verified_rounded,
          onPressed: () {},
        ),
        CustomButton(
          text: "Title",
          size: CustomButtonSize.small,
        ),
        CustomButton(
          text: "Title",
          onPressed: () {},
          size: CustomButtonSize.small,
        ),
        CustomButton(
          icon: Symbols.verified_rounded,
          size: CustomButtonSize.small,
        ),
        CustomButton(
          icon: Symbols.verified_rounded,
          onPressed: () {},
          size: CustomButtonSize.small,
        ),
        CustomButton(
          text: "Title",
          icon: Symbols.verified_rounded,
          onPressed: () {},
          type: CustomButtonType.secondary,
        ),
        CustomButton(
          text: "Title",
          icon: Symbols.verified_rounded,
          type: CustomButtonType.secondary,
        ),
        CustomButton(
          text: "Title",
          icon: Symbols.verified_rounded,
          onPressed: () {},
          size: CustomButtonSize.small,
          type: CustomButtonType.secondary,
        ),
        CustomButton(
          text: "Title",
          icon: Symbols.verified_rounded,
          size: CustomButtonSize.small,
          type: CustomButtonType.secondary,
        ),
        CustomButton(
          text: "Title",
          onPressed: () {},
          type: CustomButtonType.tertiary,
        ),
        CustomButton(
          text: "Title",
          type: CustomButtonType.tertiary,
        ),
        CustomButton(
          text: "Title",
          onPressed: () {},
          type: CustomButtonType.danger,
        ),
        CustomButton(
          text: "Title",
          type: CustomButtonType.danger,
        ),
      ],
    );
  }

  Widget _label(String label) => Column(children: [
        const Divider(height: 48, thickness: 0.25),
        Text(label, style: TextStyleTheme.labelLarge),
        24.verticalSpace,
      ]);

//Testing purpose
  // void _navigateToLogin() {
  //   if (_selectedUserType != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => LoginTest(selectedUserType: _selectedUserType!),
  //       ),
  //     );
  //   } else {
  //     // Prompt user to make a selection or handle error
  //   }
  // }
}
