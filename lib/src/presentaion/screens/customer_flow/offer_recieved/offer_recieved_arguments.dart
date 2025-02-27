import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/combine_requests_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/imports.dart';

class OfferRecievedArguments {
  ValueNotifier customerNewRequest;
  // ValueNotifier<CombineRequestsResponseDto>? customerCombineRequest;

  OfferRecievedArguments(
    this.customerNewRequest,
  );
}
