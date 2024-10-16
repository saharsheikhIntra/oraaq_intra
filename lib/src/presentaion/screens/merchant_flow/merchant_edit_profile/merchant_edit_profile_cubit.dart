import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/merchant_flow/update_merchant_profile_request_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';
import 'package:oraaq/src/domain/services/job_management_service.dart';
import 'package:oraaq/src/injection_container.dart';

import '../../../../domain/entities/category_entity.dart';

part 'merchant_edit_profile_state.dart';

class MerchantEditProfileCubit extends Cubit<MerchantEditProfileState> {
  final AuthenticationServices _authServices;
  final JobManagementService _jobManagementService;
  final UserEntity user = getIt.get<UserEntity>();

  MerchantEditProfileCubit(
    this._authServices,
    this._jobManagementService,
  ) : super(MerchantEditProfileInitial());

  updateMerchantProfile({
    required String merchantName,
    required String merchantNumber,
    required String cnic,
    required String email,
    required String latitude,
    required String longitude,
    required String offDays,
    required String openingTime,
    required String closingTime,
    required int serviceType,
    required List<String> holidays,
  }) async {
    emit(MerchantProfileStateLoading());
    print("Loading state emitted");
    holidays.removeWhere((holiday) => holiday.isEmpty);

    var dto = UpdateMerchantProfileRequestDto(
      merchantId: user.id,
      merchantUserId: user.userId,
      merchantName: merchantName.isEmpty ? user.name : merchantName,
      merchantNumber: merchantNumber.isEmpty ? user.phone : merchantNumber,
      cnic: cnic.isEmpty ? user.cnicNtn : cnic,
      email: email.isEmpty ? user.email : email,
      latitude: latitude.isEmpty
          ? double.tryParse(user.latitude) ?? 0.0
          : double.tryParse(latitude) ?? 0.0,
      longitude: longitude.isEmpty
          ? double.tryParse(user.longitude) ?? 0.0
          : double.tryParse(longitude) ?? 0.0,
      openingTime: openingTime.isEmpty ? user.openingTime : openingTime,
      closingTime: closingTime.isEmpty ? user.closingTime : closingTime,
      serviceType: serviceType,
      holidays: holidays.join(','),
    );
    print("DTO created: ${dto.toMap()}");

    var result = await _authServices.updateMerchantProfile(dto);
    print("Result from service: $result");
    result.fold(
      (l) {
        print("Error state emitted: ${l.message}");
        emit(MerchantProfileStateError(l));
      },
      (r) {
        print("Success state emitted: $r");
        // final UserEntity user = getIt.get<UserEntity>();
        // print("new user enityt  " + user.name);
        // getIt.get<MerchantProfileScreenCubit>().updateMerchantDetails(user);
        emit(MerchantProfileStateSuccess(r));
      },

      // (l) => emit(MerchantProfileStateError(l)),

      // (r) => emit(MerchantProfileStateSuccess(r)),
    );
  }

  Future<void> fetchCategories() async {
    emit(MerchantProfileStateLoading());
    final result = await _jobManagementService.getCategories();
    result.fold(
      (l) => emit(MerchantProfileStateError(l)),
      (r) => emit(MerchantProfileStateCategoriesLoaded(r)),
    );
  }
}
