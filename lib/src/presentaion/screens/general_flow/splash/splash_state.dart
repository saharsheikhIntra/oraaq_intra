sealed class SplashState {}

class SplashStateInitial extends SplashState {}

class SplashStateAnimate extends SplashState {}

class SplashStateRedirect extends SplashState {
  final String nextRoute;
  final Object? arguments;
  SplashStateRedirect(this.nextRoute, {this.arguments});
}
