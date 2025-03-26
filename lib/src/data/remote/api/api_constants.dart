class   ApiConstants {
  static const String baseUrl = "http://182.184.51.177:8081";
  static const String tokenKey = "Authorization";
  static const String sendFcmNotification =
      "https://fcm.googleapis.com/fcm/send";

  //
  //>>>>>>>>>>>>>>>>>>>>>---------END-POINTS---------<<<<<<<<<<<<<<<<<<<<<
  //
//

//MARK: GENERAL FLOW
  static const String getToken = "/api/token";
  static const String login = "/api/splogin";
  static const String register = "/api/register";
  static const String generateOtp = "/api/GenerateOtp";
  static const String verifyOtp = "/api/verifyOTP";
  static const String changePassword = "/ords/oraaq/api/changePassword";
  static const String forgetPassword = "/api/forget-password";
  static const String setNewPassword = "/api/setNewPassword";
  static const String loginViaSocial = "/api/SocialRegisterLogin";
  //
  // MARK: MERCHANT FLOW
  static const String updateMerchantProfile =
      "/api/UpdateMerchantProfile";
  static const String getCanceledWorkOrdersForMerchant =
      "/api/merchantWorkorders?";
  static const String getCompletedWorkOrderMerchant =
      "/api/merchantWorkorders?";
  static const String getAppliedJobsForMerchant =
      "/api/merchantWorkorders?";
  static const String getWorkInProgressOrdersForMerchant =
      '/api/GetInProgressWorkOrdersForMerchant?merchant_id=';
  static const String cancelMerchantWorkOrder =
      '/api/cancelWorkOrder?';
  static const String getAllServiceRequests =
      "/api/getAllNewRequests?merchant_id=";
  static const String getAllRequests =
      "/api/GetAllNewRequestForMerchant?merchant_id=";

  static const String postBid = "/api/submitBid";
  static const String addRating = "/api/addRating";
  static const String getMerchantWithinRadius =
      "/api/getMerchantWithinRadius";
  static const String getAppliedJobsNew =
      "/api/get_applied_merchant_work_order?";
  static const String cancelMerchantWorkOrderForAppliedRequests =
      '/api/cancel_bid_for_merchant?';

  // MARK: CUSTOMER FLOW

  static const String updateCustomerProfile = '/api/updateCustomer';

  static const String getMerchantById = "/api/get_merchant_by_id/"; //NO USE

  static const String getAllCategories = "/api/getCategories";
  static const String newAllCategories = "/api/Get_Categories";
  static const String fetchAcceptedRequests =
      '/api/fetchAcceptedRequest?';

  static const String getServices = "/api/GetService?category_id=";
  static const String getAllBids = "/api/getAllBids?order_id=";

  static const String getAllNewRequest =
      '/api/getAllNewRequests?merchant_id=';

  static const String cancelCustomerCreatedRequest =
      '/api/cancel_request';
  static const String cancelCustomerConfirmedRequest =
      '/api/cancel_c_order_by_customer';

  static const String customerWorkOrders =
      "/api/customerWorkOrders?";
  static const String fetchServiceRequests =
      "/api/fetchServiceRequests?customer_id=";
  static const String fetchCombineRequests =
      "/api/fetch_combined_requests?customer_id=";

  static const String fetchOffersForRequest =
      "/api/fetch_offers_for_request?request_id=";
  static const String updateOfferAmount = '/api/update_offer_amount';
  static const String acceptRejectOffer =
      '/api/accept_or_reject_offer';
  static const String updateOfferRadius = '/api/updateRadius';
  static const String getMerchantWithinRadius2 =
      '/api/getMerchantWithinRadius2?';
  static const String generateOrder = '/api/generateOrder2';
}
