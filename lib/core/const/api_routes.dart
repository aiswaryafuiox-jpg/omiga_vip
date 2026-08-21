class ApiRoutes {
  static const String baseURL = 'https://omigavip.com/api';
  static const String apiKey = 'mnbvcxzasdfghjklpoiuytrewqzxcvbnm';

  // Endpoints
  
  static const String login = 'https://omigavip.com/api/login';
  static const String logout = 'https://omigavip.com/api/logout';
  static const String goldRates = 'https://omigavip.com/api/get_gold_rates';
  
  // Template endpoints to prevent compile errors
  static const String verifyPin = '/apiuser_verify_pin';
  static const String updateStatusVerifyOtp = '/apiuser_update_status_verifyotp';
  static const String apiuserVerifyProfileUpdateOtp = '/apiuser_verify_profile_update_otp';
  static const String verifyOtp = '/apiuser_verify_otp';
  static const String createPin = '/apiuser_create_pin';
}