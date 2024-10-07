import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/generate_otp.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';
import 'package:oraaq/src/imports.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthenticationServices _authServices;
  OtpCubit(this._authServices) : super(OtpInitial());
  final user = getIt.get<UserEntity>();
  Future<void> generateOtp() async {
    emit(OtpLoading());
    final result = await _authServices.generateOtp(54);
    result.fold(
      (l) => emit(OtpError(l)),
      (r) => emit(OtpGenerated(r)),
    );
  }

  Future<void> verifyOtp(int otp) async {
    emit(OtpLoading());
    final result = await _authServices.verifyOtp(54, otp);
    result.fold(
      (l) => emit(OtpError(l)),
      (r) => emit(OtpVerified(r.message)),
    );
  }
}
