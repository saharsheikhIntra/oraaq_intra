import 'dart:developer';

import 'package:oraaq/src/imports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final ValueNotifier<UserType?> _selectedType = ValueNotifier(null);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetConstants.splashBackground))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
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
            child: SafeArea(
              child: ValueListenableBuilder(
                  valueListenable: _selectedType,
                  builder: (context, value, child) => Column(
                        children: [
                          const Spacer(flex: 2),
                          Hero(
                              tag: "logo",
                              child: Image.asset(
                                height: 80,
                                fit: BoxFit.cover,
                                AssetConstants.logoIconWhite,
                              )),
                          const Spacer(flex: 2),
                          Text(
                            StringConstants.letsGetStarted,
                            textAlign: TextAlign.center,
                            style: TextStyleTheme.headlineSmall
                                .copyWith(color: ColorTheme.primaryText),
                          ),

                          16.verticalSpace,
                          Text(
                            StringConstants.welcomeMessage,
                            textAlign: TextAlign.center,
                            style: TextStyleTheme.bodyMedium
                                .copyWith(color: ColorTheme.secondaryText),
                          ),
                          const Spacer(),
                          ...UserType.values.map((e) {
                            var isSelected = _selectedType.value == e;
                            return Padding(
                                padding: 12.bottomPadding,
                                child: SelectionButton(
                                  height: 64,
                                  width: double.infinity,
                                  icon: e.icon,
                                  title: e.title,
                                  isSelected: isSelected,
                                  onPressed: () => _selectedType.value =
                                      isSelected ? null : e,
                                ));
                          }),
                          // .toList(),
                          40.verticalSpace,
                          CustomButton(
                              width: double.infinity,
                              text: StringConstants.continu,
                              onPressed: _selectedType.value == null
                                  ? null
                                  : () {
                                      print(_selectedType.value);
                                      // if (getIt.isRegistered<UserType>()) getIt.unregister<UserType>();
                                      // getIt.registerSingleton<UserType>(
                                      //     _selectedType.value!);
                                      context.pushNamed(
                                        RouteConstants.loginRoute,
                                        arguments: LoginArguments(
                                            _selectedType.value!),
                                      );
                                    }),
                        ],
                      )),
            ),
          )),
    );
  }
}
