import 'package:bloc/bloc.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/add_rating.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/job_management_service.dart';
import 'package:oraaq/src/imports.dart';

import '../../../../domain/entities/failure.dart';
import '../../../../domain/entities/request_entity.dart';

part 'history_screen_state.dart';

class HistoryScreenCubit extends Cubit<HistoryScreenState> {
  final JobManagementService _jobManagementService;
  final user = getIt.get<UserEntity>();

  HistoryScreenCubit(
    this._jobManagementService,
  ) : super(HistoryScreenInitial());

  // Future<void> fetchCompletedWorkOrders(int merchantId) async {
  //   emit(HistoryScreenLoading());
  //   final result = await _jobManagementService.getCompletedWorkOrdersForMerchant(merchantId);
  //   result.fold(
  //     (l) => emit(HistoryScreenError(l)),
  //     (r) => emit(CompletedWorkOrdersLoaded(r)),
  //   );
  // }

  // Future<void> fetchCancelledWorkOrders(int merchantId) async {
  //   emit(HistoryScreenLoading());
  //   final result = await _jobManagementService.getCanceledWorkOrdersForMerchant(merchantId);
  //   result.fold(
  //     (l) => emit(HistoryScreenError(l)),
  //     (r) => emit(CancelledWorkOrdersLoaded(r)),
  //   );
  // }

  Future<void> fetchWorkOrders() async {
    emit(HistoryScreenLoading());

    final completedResult =
        await _jobManagementService.getCompletedWorkOrdersForMerchant(3);
    final cancelledResult =
        await _jobManagementService.getCanceledWorkOrdersForMerchant(3);

    if (completedResult.isLeft() || cancelledResult.isLeft()) {
      final failure = completedResult.fold((l) => l, (r) => null) ??
          cancelledResult.fold((l) => l, (r) => null);
      emit(HistoryScreenError(failure!));
    } else {
      final completedOrders = completedResult.getOrElse(() => []);
      final cancelledOrders = cancelledResult.getOrElse(() => []);
      emit(HistoryScreenLoaded(
        completedOrders: completedOrders,
        cancelledOrders: cancelledOrders,
      ));
    }
  }

  Future<void> submitRating(int orderId, int customerId, int rating) async {
    final user = getIt.get<UserEntity>();
    final addRating = AddRatingRequestDto(
        orderId: orderId,
        ratingForUserType: 3,
        merchantId: user.id,
        customerId: customerId,
        ratingBy: user.userId,
        rating: rating,
        review: "");

    final result = await _jobManagementService.addRating(addRating);

    result.fold(
      (failure) => emit(RatingErrorState(failure)),
      (message) => emit(RatingSuccessState(message)),
    );
  }
}
