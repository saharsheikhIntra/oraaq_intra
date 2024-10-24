class ApiConstants {
  static const String baseUrl = "http://portal.intraerp.com:8080";
  static const String tokenKey = "Authorization";
  static const String sendFcmNotification =
      "https://fcm.googleapis.com/fcm/send";

  //
  //>>>>>>>>>>>>>>>>>>>>>---------END-POINTS---------<<<<<<<<<<<<<<<<<<<<<
  //

  static const String getToken = "/ords/oraaq/api/token";
  static const String login = "/ords/oraaq/api/splogin";
  static const String register = "/ords/oraaq/api/register";
  static const String generateOtp = "/ords/oraaq/api/GenerateOtp";
  static const String verifyOtp = "/ords/oraaq/api/verifyOTP";
  static const String updateMerchantProfile =
      "/ords/oraaq/api/UpdateMerchantProfile";

  static const String getCanceledWorkOrdersForMerchant =
      "/ords/oraaq/api/merchantWorkorders?";
  static const String getCompletedWorkOrderMerchant =
      "/ords/oraaq/api/merchantWorkorders?";
  static const String getAppliedJobsForMerchant =
      "/ords/oraaq/api/merchantWorkorders?";
  static const String addRating = "/ords/oraaq/api/addRating";
  static const String getMerchantWithinRadius =
      "/ords/oraaq/api/getMerchantWithinRadius";

  // static const String updateProfile = "/api/updateprofile/";

  static const String getMerchantById = "/api/get_merchant_by_id/";
  static const String postBid = "/api/postbid/";
  static const String getAllServiceRequests = "/api/get_all_service_requests/";
  static const String getAllCategories = "/ords/oraaq/api/getCategories";

  static const String getServices = "/ords/oraaq/api/GetService?category_id=";

  static const String getWorkInProgressOrdersForMerchant =
      '/api/GetInProgressWorkOrdersForMerchant/';
  static const String cancelMerchantWorkOrder = '/api/CancelWorkOrder/';

  //
  static const String changePassword = '/ords/oraaq/api/changePassword';
  static const String getAllNewRequest = '/ords/oraaq/api/getAllNewRequests?merchant_id=';
  // upadte customer profile api
  static const String updateCustomerProfile = '/ords/oraaq/api/updateCustomer';
  // static const String getAllNewRequest = '/ords/oraaq/api/GetInProgressWorkOrdersForMerchant?merchant_id=';
  
}
