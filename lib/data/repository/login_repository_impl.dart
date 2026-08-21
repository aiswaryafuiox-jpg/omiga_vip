import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/api_service.dart';
import '../../core/const/api_routes.dart';
import '../../domain/repository/login_repository.dart';
import '../model/login_response_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiService _apiService;

  LoginRepositoryImpl(this._apiService);

  @override
  Future<LoginResponseModel> login(String userId, String password) async {
    final formData = FormData.fromMap({
      'user_id': userId,
      'password': password,
    });

    final responseMap = await _apiService.post(
      ApiRoutes.login,
      data: formData,
      headers: {
        'Accept': 'application/json',
        'x-api-key': 'jkjnhgtfrderfgthjwertyuijhfdscvbnvbnmjhg',
      },
    );

    // Save login credentials and token for session management/logout
    final prefs = await SharedPreferences.getInstance();
    if (responseMap['token'] != null) {
      await prefs.setString("token", responseMap['token'].toString());
    } else if (responseMap['data'] != null && responseMap['data']['token'] != null) {
      await prefs.setString("token", responseMap['data']['token'].toString());
    }
    await prefs.setString("user_id", userId);
    await prefs.setString("password", password);

    return LoginResponseModel.fromJson(responseMap);
  }
}
