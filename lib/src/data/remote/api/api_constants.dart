class ApiConstants {
  static const String baseUrl = "http://portal.intraerp.com:8080";
  static const String tokenKey = "Authorization";
  static const String sendFcmNotification =
      "https://fcm.googleapis.com/fcm/send";

  //
  //>>>>>>>>>>>>>>>>>>>>>---------END-POINTS---------<<<<<<<<<<<<<<<<<<<<<
  //
//
//GENERAL FLOW
  static const String getToken = "/ords/oraaq/api/token";
  static const String login = "/ords/oraaq/api/splogin";
  static const String register = "/ords/oraaq/api/register";
  static const String generateOtp = "/ords/oraaq/api/GenerateOtp";
  static const String verifyOtp = "/ords/oraaq/api/verifyOTP";
  static const String changePassword = "/ords/oraaq/api/changePassword";
  static const String forgetPassword = "/ords/oraaq/api/forgetPassword";
  static const String setNewPassword = "/ords/oraaq/api/setNewPassword";
  //
  //MERCHANT FLOW
  static const String updateMerchantProfile =
      "/ords/oraaq/api/UpdateMerchantProfile";
  static const String getCanceledWorkOrdersForMerchant =
      "/ords/oraaq/api/merchantWorkorders?";
  static const String getCompletedWorkOrderMerchant =
      "/ords/oraaq/api/merchantWorkorders?";
  static const String getAppliedJobsForMerchant =
      "/ords/oraaq/api/merchantWorkorders?";
  static const String getWorkInProgressOrdersForMerchant =
      '/ords/oraaq/api/GetInProgressWorkOrdersForMerchant?merchant_id=';
  static const String cancelMerchantWorkOrder =
      '/ords/oraaq/api/cancelWorkOrder?';
  static const String getAllServiceRequests =
      "/ords/oraaq/api/getAllNewRequests?merchant_id=";
  static const String postBid = "/ords/oraaq/api/submitBid";
  static const String addRating = "/ords/oraaq/api/addRating";
  static const String getMerchantWithinRadius =
      "/ords/oraaq/api/getMerchantWithinRadius";
  static const String getAppliedJobsNew =
      "/ords/oraaq/api/get_applied_merchant_work_order?";
  static const String cancelMerchantWorkOrderForAppliedRequests =
      '/ords/oraaq/api/cancel_bid_for_merchant?';

  // MARK: CUSTOMER FLOW

  static const String updateCustomerProfile = '/ords/oraaq/api/updateCustomer';

  static const String getMerchantById = "/api/get_merchant_by_id/";

  static const String getAllCategories = "/ords/oraaq/api/getCategories";
  static const String fetchAcceptedRequests =
      '/ords/oraaq/api/fetchAcceptedRequest?';

  static const String getServices = "/ords/oraaq/api/GetService?category_id=";
  static const String getAllBids = "/ords/oraaq/api/getAllBids?order_id=";

  static const String getAllNewRequest =
      '/ords/oraaq/api/getAllNewRequests?merchant_id=';

  static const String cancelCustomerCreatedRequest =
      '/ords/oraaq/api/cancel_request';
  static const String cancelCustomerConfirmedRequest =
      '/ords/oraaq/api/cancel_c_order_by_customer';

  static const String customerWorkOrders =
      "/ords/oraaq/api/customerWorkOrders?";
  static const String fetchServiceRequests =
      "/ords/oraaq/api/fetchServiceRequests?customer_id=";
  static const String fetchOffersForRequest =
      "/ords/oraaq/api/fetch_offers_for_request?request_id=";
  static const String updateOfferAmount = '/ords/oraaq/api/update_offer_amount';
  static const String acceptRejectOffer =
      '/ords/oraaq/api/accept_or_reject_offer';
  static const String updateOfferRadius = '/ords/oraaq/api/updateRadius';
  static const String getMerchantWithinRadius2 =
      '/ords/oraaq/api/getMerchantWithinRadius2?';
  static const String generateOrder = '/ords/oraaq/api/generateOrder2';
}
