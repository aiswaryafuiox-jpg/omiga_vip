import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';

import '../const/api_routes.dart';
import '../utils/navigation/app_routes.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => status != null && status < 500,
        headers: {
          "Accept": "application/json",
          "X-API-KEY": "jkjnhgtfrderfgthjwertyuijhfdscvbnvbnmjhg",
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("token");

          log("REQUEST => ${options.method}");
          log("URL => ${options.baseUrl}${options.path}");
          log("BODY => ${options.data}");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {
          log("STATUS => ${response.statusCode}");
          log("RESPONSE => ${response.data}");

          if (response.statusCode == 401) {
            if (!response.requestOptions.path.contains(ApiRoutes.verifyPin) &&
                !response.requestOptions.path.contains(ApiRoutes.updateStatusVerifyOtp) &&
                !response.requestOptions.path.contains(ApiRoutes.apiuserVerifyProfileUpdateOtp) &&
                !response.requestOptions.path.contains(ApiRoutes.verifyOtp) &&
                !response.requestOptions.path.contains(ApiRoutes.createPin) &&
                !response.requestOptions.path.contains(ApiRoutes.login)) {
              _handleUnauthorized();
            }
          }

          return handler.next(response);
        },

        onError: (DioException e, handler) {
          log("ERROR => ${e.message}");
          log("ERROR RESPONSE => ${e.response?.data}");

          g.Get.snackbar(
            "Error",
            e.response?.data?["message"] ?? "Something went wrong",
          );

          return handler.next(e);
        },
      ),
    );
  }

  /// GET API
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return _handleResponse(
      () => _dio.get(endpoint, queryParameters: queryParameters, data: data),
    );
  }

  /// POST API
  Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return _handleResponse(
      () => _dio.post(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      ),
    );
  }

  /// PUT API
  Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return _handleResponse(
      () => _dio.put(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      ),
    );
  }

  /// DELETE API
  Future<Map<String, dynamic>> delete(String endpoint, {dynamic data}) async {
    return _handleResponse(() => _dio.delete(endpoint, data: data));
  }

  /// Common Response Handler
  Future<Map<String, dynamic>> _handleResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }

      return {"data": response.data};
    } on DioException catch (e) {
      log("DIO EXCEPTION => ${e.message}");
      rethrow;
    } catch (e) {
      log("UNKNOWN ERROR => $e");
      throw Exception("Unexpected error occurred");
    }
  }

  /// POST Logout API
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("user_id") ?? "OM9728401032";
    final password = prefs.getString("password") ?? "novelxx";

    // Clean up local session variables
    await prefs.remove("token");
    await prefs.remove("user_id");
    await prefs.remove("password");

    try {
      final formData = FormData.fromMap({
        'user_id': userId,
        'password': password,
      });

      await _dio.post(
        ApiRoutes.logout,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'x-api-key': 'jkjnhgtfrderfgthjwertyuijhfdscvbnvbnmjhg',
          },
        ),
      );
    } on DioException catch (e) {
      log("LOGOUT DIO EXCEPTION => ${e.message}");
      log("LOGOUT DIO EXCEPTION RESPONSE => ${e.response?.data}");
    } catch (e) {
      log("LOGOUT UNKNOWN EXCEPTION => $e");
    }
  }

  /// Handle Unauthorized
  Future<void> _handleUnauthorized() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("user_id");
    await prefs.remove("password");

    g.Get.offAllNamed(AppRoutes.login);

    g.Get.snackbar("Session Expired", "Please login again.");
  }
}
