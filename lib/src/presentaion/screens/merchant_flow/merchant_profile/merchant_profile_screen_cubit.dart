import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';

import '../../../../injection_container.dart';

part 'merchant_profile_screen_state.dart';

class MerchantProfileScreenCubit extends Cubit<MerchantProfileScreenState> {
  final AuthenticationServices _authenticationServices;
  MerchantProfileScreenCubit(this._authenticationServices) : super(MerchantProfileScreenInitial());

  updateUser(UserEntity user) {
    final user = getIt.get<UserEntity>();
    emit(MerchantProfileScreenUpdated(user));
  }

  logout() async {
    emit(MerchantProfileScreenLoading());
    await _authenticationServices.logout();
    emit(MerchantProfileScreenLogoutSuccess());
  }
}
