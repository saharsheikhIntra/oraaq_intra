import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_profile/customer_profile_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/welcome/welcome_screen.dart';

import '../../../../config/themes/color_theme.dart';
import '../../../../config/themes/text_style_theme.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../widgets/setting_tile.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final CustomerProfileCubit _cubit = getIt.get<CustomerProfileCubit>();

  UserEntity currentUser = getIt.get<UserEntity>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: ColorTheme.scaffold,
        appBar: AppBar(title: const Text(StringConstants.profile)),
        body: BlocListener<CustomerProfileCubit, CustomerProfileState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is CustomerProfileUpdated) currentUser = state.user;
            if (state is CustomerProfileLoading) {
              DialogComponent.showLoading(context);
            }
            if (state is CustomerProfileLogoutSuccess) {
              DialogComponent.showLoading(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteConstants.welcomeRoute,
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                8.verticalSpace,
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 14, 16, 10),
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
                      Row(
                        children: [
                          Expanded(
                              child: Text(currentUser.name,
                                  style: TextStyleTheme.displaySmall)),
                          8.horizontalSpace,
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () {
                                context.pushNamed(
                                  RouteConstants.customerEditProfileRoute,
                                );
                              },
                              child: const Icon(
                                Symbols.border_color_rounded,
                                color: ColorTheme.primary,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      _buildInfo(Symbols.call_rounded, currentUser.phone),
                      6.verticalSpace,
                      _buildInfo(Symbols.mail_rounded, currentUser.email),
                      16.verticalSpace,
                    ],
                  ),
                ),
                8.verticalSpace,
                SettingTile(
                  title: 'Request History',
                  icon: Symbols.device_reset_rounded,
                  variant: SettingTileVariant.normal,
                  onTap: () {
                    context.pushNamed(
                      RouteConstants.requestHistoryScreenRoute,
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
                  onTap: () {
                    context.pushNamed(RouteConstants.TermsAndConditionsScreen);
                  },
                ),
                8.verticalSpace,
                SettingTile(
                  title: 'Privacy Policy',
                  icon: Symbols.policy_rounded,
                  variant: SettingTileVariant.external,
                  onTap: () {
                    context.pushNamed(RouteConstants.PrivacyPolicyScreen);
                  },
                ),
                const Spacer(),
                SettingTile(
                  title: 'Logout',
                  icon: Symbols.logout_rounded,
                  variant: SettingTileVariant.warning,
                  onTap: () {
                    // context.popUntil(RouteConstants.welcomeRoute);
                    _cubit.logout();
                  },
                ),
                24.verticalSpace,
              ],
            ),
          ),
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
}
