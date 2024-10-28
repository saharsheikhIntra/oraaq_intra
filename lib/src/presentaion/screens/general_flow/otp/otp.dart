import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp_cubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final ValueNotifier<bool> isOtpValid = ValueNotifier<bool>(false);
  final ValueNotifier<int> enteredOtp = ValueNotifier<int>(0);
  final OtpCubit _cubit = getIt<OtpCubit>();
  String generatedOtp = '';
  final UserType userType = getIt<UserType>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.generateOtp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {

          if (state is OtpGenerated) {
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.success,
              title: "OTP: ${state.otpResponse.otp}",
            );
            generatedOtp = state.otpResponse.otp.toString();
          }
          if (state is OtpVerified) {
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.success,
              title: state.message,
            );
            // Navigator.pushReplacementNamed(context, '/nextScreen');
            if(userType == UserType.customer){
              context.pushNamed(RouteConstants.customerEditProfileRoute);
            }else{
              context
                .pushReplacementNamed(RouteConstants.merchantEditProfileRoute);
            }
          }
          if (state is OtpError) {
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.warning,
              title: state.error.message,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              //appBar: AppBar(backgroundColor: ColorTheme.transparent),
              body: SingleChildScrollView(
                  child: Container(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                AssetConstants.splashBackground,
                              ))),
                      child: Container(
                          padding: 24.horizontalPadding,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0, 0.32, 0.75],
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.81),
                              Colors.white,
                            ],
                          )),
                          child: Column(
                            children: [
                              const Spacer(),
                              Image.asset(
                                AssetConstants.logoIcon,
                                height: 80,
                              ),
                              const Spacer(),
                              Text(
                                StringConstants.otpText,
                                textAlign: TextAlign.center,
                                style: TextStyleTheme.headlineSmall
                                    .copyWith(color: ColorTheme.primaryText),
                              ),
                              16.verticalSpace,
                              Text(
                                StringConstants.otpMessage,
                                textAlign: TextAlign.center,
                                style: TextStyleTheme.bodyMedium
                                    .copyWith(color: ColorTheme.secondaryText),
                              ),
                              16.verticalSpace,
                              Text(
                                StringConstants.sampleEmail,
                                textAlign: TextAlign.center,
                                style: TextStyleTheme
                                    .titleSmall //labelLarge not showing bold
                                    .copyWith(color: ColorTheme.onPrimary),
                              ),
                              Text(
                                StringConstants.samplePhoneNumber,
                                textAlign: TextAlign.center,
                                style: TextStyleTheme.titleSmall
                                    .copyWith(color: ColorTheme.onPrimary),
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable: isOtpValid,
                                builder: (context, value, child) => OtpWidget(
                                  onOtpVerified: isOtpValid,
                                  generatedOtp: generatedOtp,
                                  onEnteredOtp: enteredOtp,
                                ),
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              CustomButton(
                                width: ScreenUtil().screenWidth,
                                text: StringConstants.verifyOtp,
                                type: CustomButtonType.primary,
                                size: CustomButtonSize.large,
                                onPressed: () {
                                  isOtpValid.value
                                      ? _cubit.verifyOtp(enteredOtp.value)
                                      // ? context.pushNamed(
                                      //     RouteConstants.newPasswordRoute,
                                      //   )
                                      : Toast.show(
                                          context: context,
                                          variant: SnackbarVariantEnum.warning,
                                          title: "Invalid OTP",
                                          message: "Please enter a valid OTP.");
                                },
                              ),
                              const Spacer(),
                              const Divider(
                                color: ColorTheme.neutral1,
                                thickness: 3,
                              ),
                              const Spacer(),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(StringConstants.otpNotRecieve,
                                        style: TextStyleTheme.bodyLarge),
                                    8.horizontalSpace,
                                    ResendOtpWidget(
                                      duration: 20.seconds,
                                      onResend: () => _cubit.generateOtp(),
                                    ),
                                  ]),
                            ],
                          )))));
        },
      ),
    );
  }
}
