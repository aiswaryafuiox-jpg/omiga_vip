import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/api_service.dart';
import '../../core/const/api_routes.dart';
import '../../domain/repository/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final ApiService _apiService;

  LogoutRepositoryImpl(this._apiService);

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id') ?? 'OM9728401032';
    final password = prefs.getString('password') ?? 'novelxx';

    // Clear stored session data
    await prefs.remove('token');
    await prefs.remove('user_id');
    await prefs.remove('password');

    final formData = FormData.fromMap({
      'user_id': userId,
      'password': password,
    });

    try {
      await _apiService.post(
        ApiRoutes.logout,
        data: formData,
        headers: {
          'Accept': 'application/json',
          'x-api-key': 'jkjnhgtfrderfgthjwertyuijhfdscvbnvbnmjhg',
        },
      );
    } on DioException catch (e) {
      // Logging is handled inside ApiService; ignore here.
    } catch (_) {}
  }
}
