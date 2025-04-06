class ApiConstants {
  // static const String baseUrl = "http://portal.intraerp.com:8080";
  static const String baseUrl2 = "http://182.184.51.177:8081";

  static const String tokenKey = "Authorization";
  static const String sendFcmNotification =
      "https://fcm.googleapis.com/fcm/send";

  //
  //>>>>>>>>>>>>>>>>>>>>>---------END-POINTS---------<<<<<<<<<<<<<<<<<<<<<
  //
//
//GENERAL FLOW
  static const String getToken = "/api/token"; // "/ords/oraaq/api/token";
  static const String login = "/api/splogin"; //  "/ords/oraaq/api/splogin";
  static const String register = "/api/register"; //"/ords/oraaq/api/register";
  static const String generateOtp = "/api/GenerateOtp";
  static const String verifyOtp = "/api/verifyOTP";
  static const String changePassword = "/api/changePassword";
  static const String forgetPassword =
      "/api/forget-password"; //"/ords/oraaq/api/forgetPassword";
  static const String setNewPassword = "/api/setNewPassword";
  // "/ords/oraaq/api/setNewPassword";
  static const String loginViaSocial = "/api/SocialRegisterLogin";
  // "/ords/oraaq/api/SocialRegisterLogin";
  //
  //MERCHANT FLOW
  static const String updateMerchantProfile = "/api/UpdateMerchantProfile";
  // "/ords/oraaq/api/UpdateMerchantProfile";
  static const String getCanceledWorkOrdersForMerchant =
      "/api/merchantWorkorders?";
  static const String getCompletedWorkOrderMerchant =
      "/api/merchantWorkorders?";
  static const String getAppliedJobsForMerchant = "/api/merchantWorkorders?";
  static const String getWorkInProgressOrdersForMerchant =
      '/api/GetInProgressWorkOrdersForMerchant?merchant_id=';
  static const String cancelMerchantWorkOrder = '/api/cancelWorkOrder?';
  static const String getAllServiceRequests =
      "/api/getAllNewRequests?merchant_id=";
  static const String getAllRequests =
      "/api/GetAllNewRequestForMerchant?merchant_id=";

  static const String postBid = "/api/submitBid";
  static const String addRating = "/api/addRating";
  static const String getMerchantWithinRadius = "/api/getMerchantWithinRadius";
  static const String getAppliedJobsNew =
      "/api/get_applied_merchant_work_order?";
  static const String cancelMerchantWorkOrderForAppliedRequests =
      '/api/cancel_bid_for_merchant?';

  // MARK: CUSTOMER FLOW

  static const String updateCustomerProfile =
      "/api/updateCustomer"; //'/ords/oraaq/api/updateCustomer';

  static const String getMerchantById = "/api/get_merchant_by_id/"; //NO USE

  static const String getAllCategories =
      "/api/getCategories"; //"/api/getCategories";

  ///ords/oraaq/api/getCategories";
  static const String newAllCategories =
      '/api/Get_Categories'; //"/ords/oraaq/api/Get_Categories";
  static const String fetchAcceptedRequests = '/api/fetchAcceptedRequest?';
  // '/ords/oraaq/api/fetchAcceptedRequest?';

  static const String getServices =
      "/api/GetService?category_id="; //"/ords/oraaq/api/GetService?category_id=";
  static const String getAllBids = "/ords/oraaq/api/getAllBids?order_id=";

  static const String getAllNewRequest = '/api/getAllNewRequests?merchant_id=';

  static const String cancelCustomerCreatedRequest = "/api/cancel_request";
  // '/ords/oraaq/api/cancel_request';
  static const String cancelCustomerConfirmedRequest =
      "/api/cancel_c_order_by_customer";
  // '/ords/oraaq/api/cancel_c_order_by_customer';

  static const String customerWorkOrders = "/api/customerWorkOrders?";
  // "/ords/oraaq/api/customerWorkOrders?";
  static const String fetchServiceRequests =
      "/api/fetchServiceRequests?customer_id=";
  // "/ords/oraaq/api/fetchServiceRequests?customer_id=";
  static const String fetchCombineRequests =
      "/api/fetch_combined_requests?customer_id=";
  // "/ords/oraaq/api/fetch_combined_requests?customer_id=";

  static const String fetchOffersForRequest =
      '/api/fetch_offers_for_request?request_id=';
  // "/ords/oraaq/api/fetch_offers_for_request?request_id=";
  static const String updateOfferAmount = '/api/update_offer_amount';
  //  '/ords/oraaq/api/update_offer_amount';
  static const String acceptRejectOffer = '/api/accept_or_reject_offer';
  // '/ords/oraaq/api/accept_or_reject_offer';
  static const String updateOfferRadius = '/api/updateRadius';
  // '/ords/oraaq/api/updateRadius';
  static const String getMerchantWithinRadius2 =
      '/api/getMerchantWithinRadius2?';
  // '/ords/oraaq/api/getMerchantWithinRadius2?';
  static const String generateOrder =
      '/api/generateOrder2'; //'/ords/oraaq/api/generateOrder2';
}
