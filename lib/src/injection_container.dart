import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:oraaq/src/data/remote/api/api_datasource.dart';
import 'package:oraaq/src/data/remote/api/api_repositories/services_repository.dart';
import 'package:oraaq/src/data/remote/social/social_auth_repository.dart';
import 'package:oraaq/src/domain/services/services_service.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_edit_profile/customer_edit_profile_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_profile/customer_profile_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offers_recieved_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/request_history/request_history_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/forgot_password/forget_password_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/login/login_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/new_password/new_password_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/register/register_cubit.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_edit_profile/merchant_edit_profile_cubit.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_history/history_screen_cubit.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_home/merchant_home_screen_cubit.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_profile/merchant_profile_screen_cubit.dart';

import 'data/local/local_auth_repository.dart';
import 'data/local/local_datasource.dart';
import 'data/remote/api/api_constants.dart';
import 'data/remote/api/api_interceptors.dart';
import 'data/remote/api/api_repositories/auth_repository.dart';
import 'data/remote/api/api_repositories/job_management_repository.dart';
import 'domain/entities/user_entity.dart';
import 'domain/services/authentication_services.dart';
import 'domain/services/job_management_service.dart';
import 'presentaion/screens/customer_flow/customer_home/customer_home_cubit.dart';
import 'presentaion/screens/general_flow/splash/splash_cubit.dart';

final getIt = GetIt.instance;

void initializeInjectedDependencies() {
  injectDatasources();
  injectRepositories();
  injectUser();
  injectServices();
  injectCubits();
}

//
//
//
// MARK: DATA SOURCES
//
//
//

injectDatasources() {
  getIt.registerSingleton(LocalDatasource());
  // getIt.re

  Dio dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: 30000.milliseconds,
    receiveTimeout: 30000.milliseconds,
    sendTimeout: 30000.milliseconds,
  ));

  dio.interceptors.addAll([
    RequestInterceptor(dio),
    LoggerInterceptor.interceptor,
  ]);

  getIt.registerSingleton(ApiDatasource(dio));
}

//
//
//
// MARK: REPOSITORIES
//
//
//

injectRepositories() {
  getIt.registerSingleton(
    LocalAuthRepository(getIt.get()),
  );
  getIt.registerSingleton(
    ApiAuthRepository(getIt.get()),
  );
  getIt.registerSingleton(
    SocialAuthRepository(),
  );
  getIt.registerSingleton(
    JobManagementRepository(getIt.get()),
  );
  getIt.registerSingleton(
    ServicesRepository(getIt.get()),
  );
}

//
//
//
// MARK: USER
//
//
//

injectUser() async {
  await getIt.get<LocalAuthRepository>().getUser().then(
        (result) => result.fold(
          (l) => null,
          (r) => getIt.registerSingleton<UserEntity>(r),
        ),
      );
}

//
//
//
// MARK: SERVICES
//
//
//

injectServices() {
  getIt.registerSingleton(
    AuthenticationServices(getIt(), getIt(), getIt()),
  );
  getIt.registerSingleton(
    JobManagementService(getIt()),
  );
  getIt.registerSingleton(
    ServicesService(getIt()),
  );
}

//
//
//
// MARK: CUBITS
//
//
//

injectCubits() {
  getIt.registerFactory(() => SplashCubit());
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => RegisterCubit(getIt()));
  getIt.registerFactory(() => OtpCubit(getIt()));
  getIt.registerFactory(() => ForgetPasswordCubit(getIt()));
  getIt.registerFactory(() => NewPasswordCubit(getIt()));
  getIt.registerFactory(() => MerchantEditProfileCubit(getIt(), getIt()));
  getIt.registerFactory(() => MerchantProfileScreenCubit(getIt()));
  getIt.registerFactory(() => HistoryScreenCubit(getIt()));
  getIt.registerFactory(() => MerchantHomeScreenCubit(getIt()));

  getIt.registerFactory(() => PickLocationCubit(getIt()));
  getIt.registerFactory(() => QuestionnaireCubit(getIt()));
  getIt.registerFactory(() => CustomerHomeCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => ChangePasswordCubit(getIt()));

  getIt.registerFactory(() => CustomerEditProfileCubit(getIt()));
  getIt.registerFactory(() => RequestHistoryCubit(getIt(), getIt()));

  getIt.registerFactory(() => OffersRecievedCubit(getIt()));
  getIt.registerFactory(() => CustomerProfileCubit(getIt()));
}
