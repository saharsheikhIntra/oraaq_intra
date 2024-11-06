import 'package:bloc/bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';

part 'customer_profile_state.dart';

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  final AuthenticationServices _authenticationServices;
  CustomerProfileCubit(this._authenticationServices) : super(CustomerProfileInitial());

  logout() async {
    emit(CustomerProfileLoading());
    await _authenticationServices.logout();
    emit(CustomerProfileLogoutSuccess());
  }
}
