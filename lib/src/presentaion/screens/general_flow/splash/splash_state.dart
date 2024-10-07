sealed class SplashState {}

class SplashStateInitial extends SplashState {}

class SplashStateAnimate extends SplashState {}

class SplashStateRedirect extends SplashState {
  final String nextRoute;
  SplashStateRedirect(this.nextRoute);
}
