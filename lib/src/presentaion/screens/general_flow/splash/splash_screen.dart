import 'package:oraaq/src/core/extensions/context_extensions.dart';
import 'package:oraaq/src/imports.dart';

import 'splash_cubit.dart';
import 'splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashCubit _cubit = getIt.get<SplashCubit>();
  final _duration = 600.milliseconds;
  final _curve = Curves.easeOut;

  bool expandLogo = false;

  @override
  void initState() {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((timeStamp) => _cubit.animate());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) =>
          context.popAllNamed(RouteConstants.customerHomeScreenRoute),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            switch (state) {
              case SplashStateInitial():
                break;
              case SplashStateAnimate():
                expandLogo = true;
                break;
              case SplashStateRedirect():
                context.popAllNamed(state.nextRoute);
                break;
            }
          },
          builder: (context, state) {
            return Container(
                width: double.infinity,
                height: ScreenUtil().screenHeight,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetConstants.splashBackground),
                )),
                alignment: Alignment.center,
                child: AnimatedContainer(
                    height: 100,
                    width: expandLogo ? 230 : 100,
                    duration: _duration,
                    curve: _curve,
                    margin: EdgeInsets.only(
                      left: expandLogo ? 0 : 130,
                      right: expandLogo ? 0 : 65,
                    ),
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                            width: 230,
                            height: 100,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                AnimatedOpacity(
                                    duration: _duration,
                                    curve: _curve,
                                    opacity: expandLogo ? 1 : 0.65,
                                    child: Hero(
                                        tag: "logo",
                                        child: Image.asset(
                                          AssetConstants.logo,
                                          fit: BoxFit.cover,
                                          height: 100,
                                        ))),
                                AnimatedContainer(
                                  height: 100,
                                  curve: Curves.easeInQuint,
                                  width: expandLogo ? 0 : 130,
                                  duration: _duration,
                                  color: Colors.white,
                                ),
                              ],
                            )))));
          },
        ),
      ),
    );
  }
}
