import 'package:oraaq/src/core/extensions/timeofday_extensions.dart';
import 'package:oraaq/src/imports.dart';

import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_profile/merchant_profile_screen_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final MerchantProfileScreenCubit _cubit =
      getIt.get<MerchantProfileScreenCubit>();
  UserEntity _user = getIt.get<UserEntity>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: Scaffold(
            backgroundColor: ColorTheme.scaffold,
            appBar: AppBar(title: const Text(StringConstants.profile)),
            body: BlocConsumer<MerchantProfileScreenCubit,
                MerchantProfileScreenState>(
              listener: (context, state) {
                if (state is MerchantProfileScreenUpdated) _user = state.user;
                if (state is MerchantProfileScreenLoading) {
                  DialogComponent.showLoading(context);
                }
                if (state is MerchantProfileScreenLogoutSuccess) {
                  DialogComponent.showLoading(context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteConstants.welcomeRoute,
                    (Route<dynamic> route) => false,
                  );
                }
              },
              builder: (context, state) {
                return _buildUi();
              },
            )));
  }

  Widget _buildUi() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            8.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: 12.borderRadius,
                color: ColorTheme.white,
                border: Border.all(
                  color: ColorTheme.neutral1,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 14, 16, 8),
                      child: Row(children: [
                        Expanded(
                            child: Text(_user.name,
                                //StringConstants.sampleUserName,
                                style: TextStyleTheme.displaySmall)),
                        8.horizontalSpace,
                        Material(
                            color: Colors.transparent,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () async {
                                  var result = await context.pushNamed(
                                      RouteConstants.merchantEditProfileRoute);
                                  if (result is UserEntity) {
                                    _cubit.updateUser(result);
                                  }
                                },
                                child: const Icon(
                                  Symbols.border_color_rounded,
                                  color: ColorTheme.primary,
                                  size: 24,
                                ))),
                      ])),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Column(
                      children: [
                        _buildInfo(
                          Symbols.call_rounded,
                          _user.phone,
                          //StringConstants.samplePhoneNumber
                        ),
                        6.verticalSpace,
                        _buildInfo(
                          Symbols.mail_rounded,
                          _user.email,
                          //StringConstants.sampleEmail,
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  const Divider(
                    thickness: 2,
                    color: ColorTheme.neutral1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 5.5, 16),
                    child: Column(
                      children: [
                        16.verticalSpace,
                        _buildData(
                          Symbols.build_rounded,
                          "Service Type",

                          _user.serviceType == 1
                              ? "AC Service"
                              : _user.serviceType == 2
                                  ? "Salon"
                                  : _user.serviceType == 21
                                      ? "Catering"
                                      : _user.serviceType == 41
                                          ? "Mechanic"
                                          : "Other",
                          //"Saloon"
                        ),
                        16.verticalSpace,
                        _buildData(
                          Symbols.pin_rounded, "CNIC / NTN",
                          _user.cnicNtn,
                          //"41304-1234567-8"
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            _buildData(
                              Symbols.schedule_rounded, "Opening Time",
                              OnTimeOfDay.formatTo12Hour(_user.openingTime),
                              // _user.openingTime

                              //"09:00 PM"
                            ),
                            16.horizontalSpace,
                            _buildData(
                              null,
                              "Closing Time",
                              OnTimeOfDay.formatTo12Hour(_user.closingTime),
                              // _user.closingTime,
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        _buildData(
                          Symbols.deck_rounded,
                          "Holidays",
                          _user.holidays,
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            _buildData(
                              Symbols.distance_rounded,
                              "Location",
                              "${_user.latitude}, ${_user.longitude}",
                            ),
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () => LauncherUtil.openMap(
                                  double.tryParse(_user.latitude) ?? 25.3960,
                                  double.tryParse(_user.longitude) ?? 68.3578,
                                ),
                                child: const Icon(
                                  Symbols.near_me_rounded,
                                  color: ColorTheme.primary,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            8.verticalSpace,
            SettingTile(
              title: 'Jobs History',
              icon: Symbols.history_rounded,
              variant: SettingTileVariant.normal,
              onTap: () {
                context.pushNamed(
                  RouteConstants.historyScreenRoute,
                );
              },
            ),
            8.verticalSpace,
            SettingTile(
              title: 'Change Password',
              icon: Symbols.password_rounded,
              variant: SettingTileVariant.normal,
              onTap: () {
                context.pushNamed(
                  RouteConstants.changePasswordRoute,
                );
              },
            ),
            8.verticalSpace,
            SettingTile(
              title: 'Terms & Conditions',
              icon: Symbols.privacy_tip_rounded,
              variant: SettingTileVariant.external,
              onTap: () {},
            ),
            8.verticalSpace,
            SettingTile(
              title: 'Privacy Policy',
              icon: Symbols.policy_rounded,
              variant: SettingTileVariant.external,
              onTap: () {},
            ),
            8.verticalSpace,
            SettingTile(
              title: 'Pause Service',
              icon: Symbols.pause_circle_rounded,
              variant: SettingTileVariant.warning,
              onTap: () {
                SheetComponenet.showWarningSheet(
                  context,
                  title: "Considering a break from offering your services?",
                  message:
                      "Oraaq will temporarily pause recommending your services to customers. Take the time you need, and when you're ready to return, we'll be here to support you.",
                  ctaText: "Pause Service",
                  cancelText: "Cancel",
                  onCtaTap: () {
                    context.pop();
                  },
                  onCancelTap: () => context.pop(),
                );
              },
            ),
            8.verticalSpace,
            SettingTile(
              title: 'Logout',
              icon: Symbols.logout_rounded,
              variant: SettingTileVariant.warning,
              onTap: _cubit.logout,
            ),
            21.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(IconData icon, String text) => Row(children: [
        Icon(
          icon,
          color: ColorTheme.secondaryText,
          size: 18.0,
        ),
        8.horizontalSpace,
        Text(text,
            style: TextStyleTheme.bodyMedium.copyWith(
              color: ColorTheme.secondaryText,
            )),
      ]);

  Widget _buildData(IconData? icon, String heading, String value) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: ColorTheme.neutral3,
            size: 20,
          ),
        ],
        16.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: TextStyleTheme.labelSmall
                  .copyWith(color: ColorTheme.neutral3),
            ),
            Text(
              value,
              style: TextStyleTheme.bodyLarge
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }
}
